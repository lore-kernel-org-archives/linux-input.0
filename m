From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 8/17] input: RMI4 F09 Built-In Self Test
Date: Mon, 27 Aug 2012 15:07:48 -0700
Message-ID: <CACRpkdaq7StwG_jg+hZCcU668=VrcUeZa7qP6R_2v9ugkkX38w@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
	<1345241877-16200-9-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47934 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab2H0WHt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Aug 2012 18:07:49 -0400
Received: by wibhr14 with SMTP id hr14so3992171wib.1
        for <linux-input@vger.kernel.org>; Mon, 27 Aug 2012 15:07:48 -0700 (PDT)
In-Reply-To: <1345241877-16200-9-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Henrik Rydberg <rydberg@euromail.se>

On Fri, Aug 17, 2012 at 3:17 PM, Christopher Heiny <cheiny@synaptics.com> wrote:

Put in a verbose description of what this is.

(...)
> +++ b/drivers/input/rmi4/rmi_f09.c

> +/* data specific to fn $09 that needs to be kept around */
> +struct f09_query {
> +       u8 limit_register_count;
> +       union {
> +               struct {
> +                       u8 result_register_count:3;
> +                       u8 reserved:3;
> +                       u8 internal_limits:1;
> +                       u8 host_test_enable:1;
> +               };
> +               u8 f09_bist_query1;
> +       };
> +};

__attribute__((packed));

?

> +struct f09_control {
> +       union {
> +               struct {
> +                       u8 test1_limit_low:8;
> +                       u8 test1_limit_high:8;
> +                       u8 test1_limit_diff:8;
> +               };
> +               u8 f09_control_test1[3];
> +       };
> +       union {
> +               struct {
> +                       u8 test2_limit_low:8;
> +                       u8 test2_limit_high:8;
> +                       u8 test2_limit_diff:8;
> +               };
> +               u8 f09_control_test2[3];
> +       };
> +};

__attribute__((packed));

?

> +struct f09_data {
> +       u8 test_number_control;
> +       u8 overall_bist_result;
> +       u8 test_result1;
> +       u8 test_result2;
> +       u8 transmitter_number;
> +
> +       union {
> +               struct {
> +                       u8 receiver_number:6;
> +                       u8 limit_failure_code:2;
> +               };
> +               u8 f09_bist_data2;
> +       };
> +};

__attribute__((packed));

?

> +struct f09_cmd {
> +       union {
> +               struct {
> +                       u8 run_bist:1;
> +               };
> +               u8 f09_bist_cmd0;
> +       };
> +};

__attribute__((packed));

?

(...)
> +static struct device_attribute attrs[] = {
> +       __ATTR(status, RMI_RW_ATTR,
> +                  rmi_f09_status_show, rmi_f09_status_store),
> +       __ATTR(limitRegisterCount, RMI_RO_ATTR,
> +              rmi_f09_limit_register_count_show, rmi_store_error),
> +       __ATTR(hostTestEnable, RMI_RW_ATTR,
> +              rmi_f09_host_test_enable_show, rmi_f09_host_test_enable_store),
> +       __ATTR(internalLimits, RMI_RO_ATTR,
> +              rmi_f09_internal_limits_show, rmi_store_error),
> +       __ATTR(resultRegisterCount, RMI_RO_ATTR,
> +              rmi_f09_result_register_count_show, rmi_store_error),
> +       __ATTR(overall_bist_result, RMI_RO_ATTR,
> +              rmi_f09_overall_bist_result_show, rmi_store_error),
> +       __ATTR(test_number_control, RMI_RW_ATTR,
> +              rmi_f09_test_number_control_show,
> +              rmi_f09_test_number_control_store),
> +       __ATTR(test_result1, RMI_RO_ATTR,
> +              rmi_f09_test_result1_show, rmi_store_error),
> +       __ATTR(test_result2, RMI_RO_ATTR,
> +              rmi_f09_test_result2_show, rmi_store_error),
> +       __ATTR(run_bist, RMI_RW_ATTR,
> +              rmi_f09_run_bist_show, rmi_f09_run_bist_store),
> +       __ATTR(f09_control_test1, RMI_RW_ATTR,
> +              rmi_f09_control_test1_show, rmi_f09_control_test1_store),
> +       __ATTR(f09_control_test2, RMI_RW_ATTR,
> +              rmi_f09_control_test2_show, rmi_f09_control_test2_store),
> +};

If this is *only* for tests, then for sure this should be in debugfs?

> +static int rmi_f09_alloc_memory(struct rmi_function_container *fc)
(...)
> +static void rmi_f09_free_memory(struct rmi_function_container *fc)

Why do you need separate functions for these two?

If they are only used from one place (which I suspect) then just
put the code at that site.

(...)
> +static int rmi_f09_initialize(struct rmi_function_container *fc)
> +{
> +       struct rmi_device *rmi_dev = fc->rmi_dev;
> +       struct rmi_device_platform_data *pdata;
> +       struct rmi_fn_09_data *f09 = fc->data;
> +       u16 query_base_addr;
> +       int rc;
> +
> +
> +       pdata = to_rmi_platform_data(rmi_dev);
> +       query_base_addr = fc->fd.query_base_addr;
> +
> +       /* initial all default values for f09 query here */
> +       rc = rmi_read_block(rmi_dev, query_base_addr,
> +               (u8 *)&f09->query, sizeof(f09->query));
> +       if (rc < 0) {
> +               dev_err(&fc->dev, "Failed to read query register."
> +                       " from 0x%04x\n", query_base_addr);
> +               return rc;
> +       }
> +
> +       return 0;
> +}

Similar here. Cannot this be brought into the only call site?

> +static int rmi_f09_config(struct rmi_function_container *fc)
> +{
> +       /*we do nothing here. instead reset should notify the user.*/
> +       return 0;
> +}

Make it optional and just don't define it.

> +static int rmi_f09_reset(struct rmi_function_container *fc)
> +{
> +       struct  rmi_fn_09_data  *instance_data = fc->data;
> +
> +       instance_data->status = -ECONNRESET;
> +
> +       return 0;
> +}

Dito.

(Already remarked this at the last patch.)

Yours,
Linus Walleij
