angular.module('bhima.services')
  .service('FiscalService', FiscalService);

FiscalService.$inject = ['PrototypeApiService'];

/**
 * @class FiscalService
 * @extends PrototypeApiService
 *
 * This service is responsible for loading the Fiscal Years and Periods, as well
 * as providing metadata like period totals, opening balances and such.
 *
 * @requires PrototypeApiService
 */
function FiscalService(Api) {

  // extend the PrototypeApiService with fiscal routes
  const service = new Api('/fiscal/');

  // TODO - rename this something like 'byDate()'
  service.closing = closing;
  service.fiscalYearDate = fiscalYearDate;
  service.periodicBalance = periodicBalance;
  service.setOpeningBalance = setOpeningBalance;
  service.periodFiscalYear = periodFiscalYear;
  service.getOpeningBalance = getOpeningBalance;

  /**
   * @method fiscalYearDate
   *
   * @description
   * Find the fiscal year for a given date.
   */
  function fiscalYearDate(params) {
    const url = service.url.concat('date');
    return service.$http.get(url, { params })
      .then(service.util.unwrapHttpResponse);
  }

  /**
   * @method periodBalance
   *
   * @description find the balance for a specified period and fiscal year
   * @param {object} params which contains the fiscal year id and the period number
   * @example
   * periodicBalance({id: 1, period_number: 0});
   */
  function periodicBalance(params) {
    const url = service.url.concat(params.id, '/balance/', params.period_number);

    return service.$http.get(url)
      .then(service.util.unwrapHttpResponse);
  }

  /**
   * @function getOpeningBalance
   *
   * @description
   * Returns the opening balance for all accounts in a fiscal year.
   */
  function getOpeningBalance(fiscalYearId) {
    const url = `${service.url}${fiscalYearId}/opening_balance`;
    return service.$http.get(url)
      .then(service.util.unwrapHttpResponse);
  }

  /**
   * @method setOpeningBalance
   *
   * @description set the opening balance for a fiscal year
   */
  function setOpeningBalance(params) {
    const url = service.url.concat(params.id, '/opening_balance/');
    return service.$http.post(url, { params })
      .then(service.util.unwrapHttpResponse);
  }

  /**
   * @method closing
   *
   * @description closing a fiscal year
   */
  function closing(params) {
    const url = service.url.concat(params.id, '/closing');
    return service.$http.put(url, { params })
      .then(service.util.unwrapHttpResponse);
  }

  /**
   * @method periodFiscalYear
   *
   * @description get all period of all fiscal Year
   */
  function periodFiscalYear() {
    const url = service.url.concat('period');
    return service.$http.get(url)
      .then(service.util.unwrapHttpResponse);
  }

  return service;
}
