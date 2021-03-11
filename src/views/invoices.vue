<template>
  <div>
    <h2 class="content-block">Invoices</h2>

    <div
      v-if="loader" 
      class="d-flex"
    >
      <dx-load-indicator
        id="large-indicator"
        class="mx-auto"
        :height="60"
        :width="60"
      />
    </div>

    <dx-data-grid
      v-else
      class="dx-card wide-card"
      :data-source="invoices"
      key-expr="InvoiceNumber"
      :focused-row-index="0"
      :show-borders="false"
      :focused-row-enabled="true"
      :column-auto-width="true"
      :column-hiding-enabled="true"
    />
  </div>
</template>

<script>
import axios from 'axios';
import DxDataGrid from 'devextreme-vue/data-grid';
import { DxLoadIndicator } from 'devextreme-vue/load-indicator';


export default {
  data() {
    return {
      invoices: [],
      loader: true,
    };
  },
  created() {
    this.getInvoices()
  },
  components: {
    DxDataGrid,
    DxLoadIndicator
  },
  methods: {
    async getInvoices() {
      this.loader = true;
      const url = 'https://api.adthos.com/api/v1.0/ElectronicInvoicing/GetInvoices?stationOwnerId=a795633d-7411-4de2-b43c-202d8c3634e1&agencyId'
      const userName = 'ApiUser';
      const pass = '1';

      try {
        const {data: {Results}} = await axios.get(url, {
          headers: {
            Authorization: `Basic ${btoa(`${userName}:${pass}`)}`,
          },
        });

        this.invoices = Results.map(({Items}) => Items.reduce((acc, {Field, Value}) => {
          acc[Field] = Value;
          return acc;
        }, {}));
      } catch (e) {
        console.log(e);
      } finally {
        this.loader = false;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.d-flex {
  display: flex;
}

.mx-auto {
  margin: 0 auto;
}
</style>
