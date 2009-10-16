From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] input/misc: new ADXL345/346
	driver
Date: Fri, 16 Oct 2009 10:06:23 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D0E5EA7BC@limkexm3.ad.analog.com>
References: <1255516029-30023-1-git-send-email-vapier@gentoo.org>
	<1255517680-30733-1-git-send-email-vapier@gentoo.org>
	<20091016043627.GC11582@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20091016043627.GC11582-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Chris Verges <chrisv-TDbMi1wZJFNf2ZY+IB7+a9BPR1lH4CV8@public.gmane.org>, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

>> +	if (int_stat & SINGLE_TAP) {
>> +		if (tap_stat & TAP_X_SRC)
>> +			adxl34x_report_key_single(ac->input,
>> +						  pdata->ev_code_tap_x);
>> +		if (tap_stat & TAP_Y_SRC)
>> +			adxl34x_report_key_single(ac->input,
>> +						  pdata->ev_code_tap_y);
>> +		if (tap_stat & TAP_Z_SRC)
>> +			adxl34x_report_key_single(ac->input,
>> +						  pdata->ev_code_tap_z);
>> +	}
>> +
>> +	if (int_stat & DOUBLE_TAP) {
>> +		if (tap_stat & TAP_X_SRC)
>> +			adxl34x_report_key_double(ac->input,
>> +						  pdata->ev_code_tap_x);
>> +		if (tap_stat & TAP_Y_SRC)
>> +			adxl34x_report_key_double(ac->input,
>> +						  pdata->ev_code_tap_y);
>> +		if (tap_stat & TAP_Z_SRC)
>> +			adxl34x_report_key_double(ac->input,
>> +						  pdata->ev_code_tap_z);
>> +	}
>
>Hmm.. this generates loads of syncs... how about having tap codes in an
>array and do:
>
>void send_key_events(ac, pdata, status, press)
>{
>	for (i = 0; i < num, i++) {
>		if (status & (1 << i))
>			input_report_key(ac->input,
>					 pdata->ev_code_tap[i], press);
>	}
>}
>
>void do_tap(ac, pdata, status)
>{
>	send_key_events(ac, pdata, int_stat, true);
>	input_sync(ac->input);
>	send_key_events(ac, pdata, int_stat, false);
>}
>
>And you'd do:
>
>	if (int_stat & (SINGLE_TAP|DOUBLE_TAP) {
>		do_tap(ac, pdata, status);
>
>		if (int_stat & DOUBLE_TAP)
>			do_tap(ac, pdata, status);
>	}
>
>?

That's a great idea - Thanks!

>> +void adxl34x_disable(struct adxl34x *ac)
>> +{
>> +	mutex_lock(&ac->mutex);
>> +	if (!ac->disabled && ac->opened) {
>> +		ac->disabled = 1;
>> +		cancel_work_sync(&ac->work);
>
>If you actually cancel the work before it runs you will leave interrupt
>disabled for good. You need to check the return core and re-enable
>interrupt if needed.

Good catch - will fix it.

-Michael
