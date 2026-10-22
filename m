Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792676710;
	b=YM6MdpGJvilKNzBriyfZLwD1ZVT2GvpwSBwbT1XbY0oqUnhF6KzQezyXAkNX08IkMCaB
	 Ct+RWkjtVqTZQ7WXzTtUZ7CmHGwHTHNmyo7ajc1Or/WIzYeHBd6aJD1SsdtXFGWDzK6ZW
	 O8wTKY99K40UFU9CB147OXhnkD00MKTro6OVn0U1lD3152FZ4TmCqvO1M3/KhPC6At+gt
	 Sg3lU9KtMlDe+XRCi0OZBhbAjUhRhMoAFh+Lle/V0qmWzX7Hy5rnHM81r4zSA1FKl7rtc
	 OyH4FOSlFqAsUqdnRLyrlkOS5QcVDLTL0APo6sk5Iy9oZpQIpE9v7Xp3dQlGpRLwmow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676710;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2rgFFb1JouG2mVsaDyOTx/jn6UdyBqBiHcq0IgmVzZE=;
	b=Z/0I4hUxUnrEtcoqiJT1Xf6XCKKCV65NtlbjJhTroBJ5fjqONZfp5dgyGtakO5Ld1VPe
	 DE95bEYRDGORUdrHZEq2sq0Zkb/cA1jcilCDLTs/ScN+TGW7JIOYawVI8+O9ZrAcZhsx1
	 g+BAH/a1wJD+dsnjmAbrUV1FujnvDILv4MRRhKBhjrt0g4Oxv6RIiEuGB1jhlWb3/yPMV
	 Tw0ANNN8Ma4aCMRJKVoK1WfLFR7asBulimTMWfpb4M1JPEp7zOGF8GaIOyq5acrCs8pql
	 O5WUMEtbu5m2eKL1AXjy0+DZg/EAOkeEOOWHU6wRKuPQZwVXh5E/0dEMf+yiZnLXitQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MnPE1z03;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136760A5BE3;
	Thu, 22 Oct 2026 13:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8136760A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MnPE1z03
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::109])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 75766200BB9;
	Thu, 22 Oct 2026 15:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792676705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rgFFb1JouG2mVsaDyOTx/jn6UdyBqBiHcq0IgmVzZE=;
	b=MnPE1z03dopvyrYVfdrP4gsXe0pRhVtFD0gEJqrH9prFnbjifYvEFTW76V+wi/qZowjJBG
	ipKobJfPcYyyvfDioYmbvsNJniWJmAzCkQIsuxYzP0AW8kxDwPHiPuZdLZ1OKqLranRZqt
	Ckyg/0pIo0IIOkFXkUc11nGk2hcb13BDR+cSAOV07NGKRl+/mkKFYgNKW2YedQJMFVPboZ
	hSL0DDbKmEYdotkOX0oLkwinS6Ycd5pW+WLPzJnP2lHyfMgVhCl7A1RgKemP7uS0eV9ZRb
	wgP49YDcuZz8bD7bmNG042o8mtwXp2kVoPk87bCGC6NzQMo8zW2FdFsaVoFvhw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792676705; a=rsa-sha256;
	cv=none;
	b=CvcShZrpzK3np+yhnis7iQ/a/XoC1dKVxzq+bvcP9Sdvoeei2P3lAJ9VsmTASpQ8SYw42i
	wxmrm6q9/BOF0J/VJpgTTsBbjvRtcpdTHW0Qhfn3EjWHdkOlU+UqS8kL2q88T7I7ZwYHSv
	8iTRgYT6iM6gl2jDXNZYSsTX3hTM+5nIcykFx/przvBnCGv1NW/mp9BcZncG0Dw1MnySWv
	7MNMZ2LEQ+nELItovdQmrqskdetEN6FP3QLlRDpsWpDB1vFvT0KYJaqbadrT1KbNQwFexT
	+MhZpIO5ihBaVFl47HErxcmVq9tE2Egp1BkjTgF8V0c5KFW7GtXKJoR5b7vRKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=mfe@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792676705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rgFFb1JouG2mVsaDyOTx/jn6UdyBqBiHcq0IgmVzZE=;
	b=ZB6Gma4mmHcVCA6ZoQTj0yA8M6WU+og48KLo66VcN0t/5YexhGBlUPB6oHVWfvJbrBhuoy
	YvCuGahEdnbIQ+fsygBOLK8WmJqs/57g2YY7OYmcrcPWffOf38NLhWGAMXRsczPJcZ3bie
	r5bHQ2z/Z/wt5aHgi1XvsJIjaQWtf/c0Pkj3MBvnYggKd5VnXL2QMT2Dx88czAFTC0yp5h
	fD8cTOzucQKTtehmm1BNrfUDHLwJLr2XWvrhIX9F1GzB0BsgYs+uAfA405+rVTC30obdJB
	8NIsmlZo0qfRJ0P7+ezPKeNgfZoQBGGI8i9YYGOUlys2e+D8fSPJFnabkONqiw==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1064)
	id 551931BFC86; Thu, 22 Oct 2026 15:45:05 +0200 (CEST)
Date: Thu, 22 Oct 2026 15:45:05 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Andrew Thomas <andrew.thomas@touchnetix.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <h6o7st54umxqurpe47nlr4wj5fhm63avntpwl3dohem4szchcf@hic7wxfa6ekc>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
 <cf3nlougoxwlenjacl3ij2d5d5iqeqdd2whcrnnpr67qlzg6xj@p6c3bebapu7s>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3nlougoxwlenjacl3ij2d5d5iqeqdd2whcrnnpr67qlzg6xj@p6c3bebapu7s>

On 26-08-20 16:14, Andrew Thomas wrote:
> Hi Marco,

...

> > +What:		/sys/bus/i2c/devices/xxx/fw_status
> > +Date:		Jan 2026
> > +Contact:	linux-input@vger.kernel.org
> > +Description:
> > +		Reports the firmware status provided by the touchscreen. It may
> > +		be either "release" or "engineering".
> 
> This is right, it is release. However in the driver you refer to "production",
> which does not match.

Sure, I will update the driver!

> > +
> > +		Access: Read
> > +
> 
> ...
> 
> > + * The devices have a 16bit ADC but Touchnetix used the lower two bits for other
> > + * information.
> > + */
> > +#define AXIOM_MAX_XY				(65535 - 3)
> 
> This assumes ENABLECOORDINATESCALING is set in u41.

Yes, but I would like to keep it this way. Given the fact that we have a
16-bit value and cut only the lower 2 LSBs

> > +#define AXIOM_DEFAULT_POLL_INTERVAL_MS		10
> > +#define AXIOM_PAGE_BYTE_LEN			256
> > +#define AXIOM_MAX_XFERLEN			0x7fff
> > +#define AXIOM_MAX_TOUCHSLOTS			10
> > +#define AXIOM_MAX_TOUCHSLOTS_MASK		GENMASK(9, 0)
> > +
> 
> ...
> 
> > + * same usage to handle different usage revisions.
> > + *
> > + * Note:
> > + * During a th2cfgbin update the driver may use usages not listed here.
> > + * Therefore the th2cfgbin update compares the current running FW again the
> > + * th2cfgbin targets FW.
> > + */
> > +static const struct axiom_usage_info driver_required_usages[] = {
> 
> Is this too strict?

The programmer's manual clearly states that the host must validate all
used usages. I don't see an issue with beeing strict, if you release a
new firmware with new usage revisions, you can adapt the driver in
parallel.

> Could you split it into "update" and "required"?

The driver is already very complex (for a touchscreen), just to handle
the "host must validate all used usages" case. So no, I don't think that
this makes sense now.

> So a probe succeeds with "update" usages, so you can atleast get touch
> reports, but a download is blocked without them.

In case a firmware was found, which is currently not supported by the
driver, the device can still be updated. That being said, this mechanism
requires that the Touchnetix bootloader protocol is never changed or at
least changed in a backward compatible way.

> Also should u64 be optional?

Nope, please see above.

> 
> > +	AXIOM_REPORT_USAGE(AXIOM_U01, 1, axiom_u01_rev1_process_report),
> > +	AXIOM_REPORT_USAGE(AXIOM_U01, 3, axiom_u01_rev1_process_report),
> > +	AXIOM_USAGE(AXIOM_U02, 1),
> > +	AXIOM_USAGE(AXIOM_U02, 2),
> > +	AXIOM_USAGE(AXIOM_U04, 1),
> > +	AXIOM_RO_USAGE(AXIOM_U31, 1),
> > +	AXIOM_RO_USAGE(AXIOM_U33, 2),
> > +	AXIOM_RO_USAGE(AXIOM_U33, 3),
> > +	AXIOM_RO_USAGE(AXIOM_U33, 6),
> 
> ...
> 
> > +
> > +	return entry->info->rev_num;
> > +}
> > +
> > +static bool axiom_driver_supports_usage(struct axiom_data *ts,
> > +					unsigned char usage_num)
> 
> This is called many times before calling a given usage handler.
> Could we just check in axiom_u31_device_discover() or axiom_i2c_probe()
> for all the required usages?
> Could the "update" usages be checked in axiom_cfg/axfw_fw_prepare()?

I like the actual design:

  usageXX_handling() {

    if (!usage_not_supported())
        return;

    // Do the actual work
  }

because it keeps the usage handling and check together else the check is
done at an arbitrary place. Furthermore looping over a the list of
supported usages is really fast.

> > +{
> > +	const struct axiom_usage_info *iter = driver_required_usages;
> > +	struct device *dev = ts->dev;
> > +	int rev;
> > +
> > +	/*
> > +	 * Some features depend on the current running firmware. Don't print an
> > +	 * error if the usage for an optional feature is missing.
> > +	 */
> > +	if (!ts->usage_table[usage_num].populated) {
> > +		dev_dbg(dev, "u%02X is not supported by the current firmware\n",
> > +			usage_num);
> > +		return false;
> > +	}
> > +
> > +	rev = axiom_usage_rev(ts, usage_num);
> > +	if (rev < 0) {
> > +		dev_warn(dev, "Driver doesn't support u%02X yet\n", usage_num);
> > +		return false;
> > +	}
> > +
> > +	for (; iter; iter++) {
> 
> I assume this is supposed to be:
> for (; iter->usage_num; iter++) {

Sure, thanks!

> > +		if (iter->usage_num != usage_num)
> > +			continue;
> > +
> > +		if (iter->rev_num == rev)
> > +			return true;
> > +	}
> > +
> > +	dev_warn(dev, "Driver doesn't support u%02X rev.%d yet\n",
> > +		 usage_num, rev);
> > +
> > +	return false;
> > +}
> > +
> 
> ...
> 
> > +
> > +	/*
> > +	 * Downstream axcfg.py waits for 1sec without checking U01 HELLO. Tests
> > +	 * showed that waiting for the HELLO message isn't enough therefore we
> > +	 * need to add the additional fsleep(1sec).
> > +	 * Touchnetix said that the boot can take up to 2sec if all self tests
> > +	 * are enabled, so wait 2sec for the HELLO message.
> > +	 */
> > +	if (!axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
> > +					       msecs_to_jiffies(2 * MSEC_PER_SEC))) {
> > +		dev_err(ts->dev, "Error swreset timedout\n");
> > +		error = -ETIMEDOUT;
> > +	}
> 
> There is no reinit_completion() to go after/before wait_for_completion_timeout() for any of the calls.
> From my understanding this must be called before starting the new wait for completion.
> The 2s timeout may have hidden this.

Yes, I've already fixed this locally.

> > +	fsleep(USEC_PER_SEC);
> > +
> > +	return error;
> > +}
> > +
> 
> ...
> 
> > +	crc_report = get_unaligned_le16(&buf[len - 2]);
> > +	crc_calc = crc16(0, buf, (len - 2));
> > +
> > +	if (crc_calc != crc_report) {
> > +		dev_err_ratelimited(dev, "CRC16 mismatch!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	report_usage = buf[1];
> > +	payload = &buf[AXIOM_U34_REV1_PREAMBLE_BYTES];
> > +	len -= AXIOM_U34_REV1_PREAMBLE_BYTES - AXIOM_U34_REV1_POSTAMBLE_BYTES;
> 
> Is this right?
> Should it not be:
> len -= AXIOM_U34_REV1_PREAMBLE_BYTES;
> len -= AXIOM_U34_REV1_POSTAMBLE_BYTES;

Yes, already fixed.

> > +
> > +	switch (report_usage) {
> > +	case AXIOM_U01:
> > +	case AXIOM_U41:
> > +		/*
> > +		 * axiom_driver_supports_usage() is not required since the
> > +		 * correct .process_report() hooks are assigned during the
> > +		 * discovery.
> > +		 */
> > +		return axiom_process_report(ts, report_usage, payload, len);
> > +	default:
> > +		dev_dbg(dev, "Unsupported report u%02X received\n",
> > +			report_usage);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +static int axiom_u41_rev2_process_report(struct axiom_data *ts,
> > +					 const u8 *buf, size_t bufsize)
> > +{
> > +	struct input_dev *input = ts->input;
> > +	unsigned char id;
> > +	u16 targets;
> > +
> > +	/*
> > +	 * The input registration can be postponed but the touchscreen FW is
> > +	 * sending u41 reports regardless.
> > +	 */
> > +	if (!input)
> > +		return 0;
> > +
> > +	targets = get_unaligned_le16(&buf[AXIOM_U41_REV2_TARGETSTATUS_REG]);
> > +
> > +	for_each_set_bit(id, &ts->enabled_slots, AXIOM_MAX_TOUCHSLOTS) {
> > +		bool present;
> > +		u16 x, y;
> > +		s8 z;
> > +
> > +		axiom_u41_rev2_decode_target(buf, id, &x, &y, &z);
> > +
> > +		present = targets & BIT(id);
> > +		/* Ignore possible jitters */
> > +		if (z == AXIOM_PROX_LEVEL)
> > +			present = false;
> > +
> > +		dev_dbg(ts->dev, "id:%u x:%u y:%u z:%d present:%u",
> > +			id, x, y, z, present);
> > +
> > +		input_mt_slot(input, id);
> 
> The index in enabled_slots can be greater than num_slots since u42 does not neccesarily
> therefore this can send an out of range finger.

Sorry but I can't parse this. The slots are assigned during
axiom_u42_get_touchslots() and sashiko found a possible out-of-bound
access if the firmware reports a wrong u42 bufsize.

I fixed this out-of-bound access locally already.

> > +		if (input_mt_report_slot_state(input, MT_TOOL_FINGER, present))
> > +			touchscreen_report_pos(input, &ts->prop, x, y, true);
> > +
> > +		if (!present)
> > +			continue;
> > +
> > +		input_report_abs(input, ABS_MT_DISTANCE, z < 0 ? -z : 0);
> > +		if (ts->cds_enabled)
> > +			input_report_abs(input, ABS_MT_PRESSURE, z >= 0 ? z : 0);
> > +	}
> > +
> > +	input_sync(input);
> > +
> > +	return 0;
> > +}
> > +
> > +static int axiom_u01_rev1_process_report(struct axiom_data *ts,
> > +					 const u8 *buf, size_t bufsize)
> > +{
> > +	switch (buf[AXIOM_U01_REV1_REPORTTYPE_REG]) {
> > +	case AXIOM_U01_REV1_REPORTTYPE_HELLO:
> > +		dev_dbg(ts->dev, "u01 HELLO received\n");
> > +		axiom_complete(ts, &ts->boot_complete);
> > +		return 0;
> > +	case AXIOM_U01_REV1_REPORTTYPE_HEARTBEAT:
> > +		dev_dbg_ratelimited(ts->dev, "u01 HEARTBEAT received\n");
> > +		return 0;
> > +	case AXIOM_U01_REV1_REPORTTYPE_OPCOMPLETE:
> > +		dev_dbg(ts->dev, "u01 OPCOMPLETE received\n");
> > +		axiom_u02_handshakenvm(ts);
> > +		axiom_complete(ts, &ts->nvm_write);
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> 
> ...
> 
> > +
> > +	/*
> > +	 * Ensure that the IRQ setup is done only once since the handler belong
> > +	 * to the i2c-dev whereas the input-poller belong to the input-dev. The
> > +	 * input-dev can get unregistered during a firmware update to reflect
> > +	 * the new firmware state. Therefore the input-poller setup must be done
> > +	 * always.
> > +	 */
> > +	if (client->irq) {
> > +		if (!ts->irq_setup_done) {
> > +			error = devm_request_threaded_irq(dev, client->irq,
> > +							  NULL, axiom_irq,
> > +							  IRQF_ONESHOT,
> > +							  dev_name(dev), ts);
> > +			if (error) {
> > +				dev_err(dev, "Failed to request IRQ\n");
> 
> input_free_device() should be called.

Yes, thanks!

> > +				return error;
> > +			}
> > +			ts->irq_setup_done = true;
> > +		}
> > +	} else {
> > +		error = input_setup_polling(input, axiom_poll);
> > +		if (error) {
> > +			input_free_device(input);
> > +			dev_err(dev, "Setup polling mode failed\n");
> > +			return error;
> > +		}
> > +
> > +		input_set_poll_interval(input, ts->poll_interval);
> > +	}
> > +
> > +	input_set_drvdata(input, ts);
> > +	ts->input = input;
> > +
> > +	error = input_register_device(input);
> > +	if (error) {
> > +		input_free_device(input);
> > +		ts->input = NULL;
> > +		dev_err(dev, "Failed to register input device\n");
> > +	};
> > +
> > +	return error;
> > +}
> > +
> > +static int axiom_update_input_dev(struct axiom_data *ts)
> > +{
> > +	axiom_unregister_input_dev(ts);
> > +
> > +	return axiom_register_input_dev(ts, true);
> > +}
> > +
> > +static int axiom_parse_firmware(struct axiom_data *ts)
> > +{
> > +	struct device *dev = ts->dev;
> > +	struct gpio_desc *gpio;
> > +	int error;
> > +
> > +	ts->supplies[0].supply = "vddi";
> > +	ts->supplies[1].supply = "vdda";
> > +	ts->num_supplies = ARRAY_SIZE(ts->supplies);
> > +
> > +	error = devm_regulator_bulk_get(dev, ts->num_supplies, ts->supplies);
> > +	if (error)
> > +		return dev_err_probe(dev, error,
> > +				     "Failed to get power supplies\n");
> > +
> > +	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(gpio))
> > +		return dev_err_probe(dev, PTR_ERR(gpio),
> > +				     "Failed to get reset GPIO\n");
> > +	ts->reset_gpio = gpio;
> > +
> > +	ts->poll_interval = AXIOM_DEFAULT_POLL_INTERVAL_MS;
> > +	device_property_read_u32(dev, "poll-interval", &ts->poll_interval);
> > +
> > +	return 0;
> > +}
> > +
> > +static int axiom_power_up_device(struct axiom_data *ts)
> > +{
> > +	struct device *dev = ts->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_enable(ts->num_supplies, ts->supplies);
> > +	if (error) {
> > +		dev_err(dev, "Failed to enable power supplies\n");
> > +		return error;
> > +	}
> > +
> > +	gpiod_set_value_cansleep(ts->reset_gpio, 1);
> > +	fsleep(2000);
> > +	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> > +
> > +	fsleep(AXIOM_STARTUP_TIME_MS);
> > +
> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +static const struct i2c_device_id axiom_i2c_id_table[] = {
> > +	{ "ax54a" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, axiom_i2c_id_table);
> > +
> > +static const struct of_device_id axiom_of_match[] = {
> > +	{ .compatible = "touchnetix,ax54a", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, axiom_of_match);
> 
> This also works for ax80a. ax54 and ax80 are the same silicon but with a
> different pinout. It is up to you if you wish to add this.

If touchnetx want to add the ax80a later on and these devices are
compatible, they can use the fallback mechanism:

   compatible = "touchnetix,ax80a", "touchnetix,ax54a";

The touchnetix,ax80a needs to be documented in dt-bindings.

> > +
> > +static struct i2c_driver axiom_i2c_driver = {
> > +	.driver = {
> > +		   .name = KBUILD_MODNAME,
> > +		   .dev_groups = axiom_groups,
> > +		   .pm = pm_ptr(&axiom_pm_ops),
> > +		   .of_match_table = axiom_of_match,
> > +	},
> > +	.id_table = axiom_i2c_id_table,
> > +	.probe = axiom_i2c_probe,
> > +	.remove = axiom_i2c_remove,
> > +};
> > +module_i2c_driver(axiom_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("TouchNetix aXiom touchscreen I2C bus driver");
> > +MODULE_LICENSE("GPL");
> > 
> > -- 
> > 2.47.3
> 
> Apologies for the delay in review.

No worries :)

> I have tested with ax80a and ax198a and everything works as intended
> on both of them.

Nice!

> This version looks to be quite reliable for the firmware/config download
> which is great!

Thanks for testing.

> Tested-by: Andrew Thomas <andrew.thomas@touchnetix.com

I will add your tag for the next version.

> 
> Regards,
> Andrew
> 
> 
> 
