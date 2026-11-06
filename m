Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929802;
	b=VNXk1fGlOmGpETQ3t+GcArbP+ZgU1K/fqLYtgzP2Gme/DZtoxpsB6GtEvxdC3inNkha0
	 4vT8LpA6p4jtW3hxuoOmK3Mg6lOYmo7XvVzoIasM9k0BV4qqD55EAIVlWjjGqnv+fFTgv
	 Gbn1LUyuMGQRoyUDQP6N5wPIMHlwortRmYnhdcorI5Q9tsdHCVhGf5AwlcZ78ma7jzje/
	 v0j9l8ZR25gCwwPjoqVWIu3hiImyv8KOuTX21P5foGWce9vbhl8UVq7aMknLzCGGSezzT
	 BUYz3XN4Tyd30dDxSI+NEUA8+aY7DnArWw1m3e7vM8xHPidneqhuGuM29v8pUue2UGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929802;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vIuAthLRsh9V8gTeDHDwXX7UHZGZzrbSuPuqV6YOL4A=;
	b=PjXT1YxarGS0D2DKpbw9obCEVfuBHVOAvjK2Ax7u3uglixSAtF5GDwnn4CtI+rys4xuX
	 29s/qBsdQVKAu7kN+SdMcY6Jayg5RrvcSfQYtKm2jHQP+Zec5MIqdXioDxsmrczY3gO2s
	 jTFBirYIZv2SJFfD+vHi3oVXdOijSFctQccLlaXl0SEDzPI0Oa11oiurvijz/ZYG+5Q2d
	 DzWogcJWp20U/mfMVlCZ5pl6XWjMKWGExw+Aj4u5Z4mxnfg0BaUxnnXLzXvUpnebiGnjP
	 rPySbXcW1grTYIBnJRugd2/hTzeXdIX2yi1Oc7GGl+cOHcPZ+GdSocGe8qphnXUU4ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=IZ26Ph+E;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88D606D802;
	Fri,  6 Nov 2026 01:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C88D606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=IZ26Ph+E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793929798; x=1794188998;
	bh=vIuAthLRsh9V8gTeDHDwXX7UHZGZzrbSuPuqV6YOL4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IZ26Ph+Eo4FftkkvmSLBMRYWjoL+scwJ7rBLfpmP7E2jjUDT+h3XMMEXZ/axQ/5Wc
	 9pnnlsCs2lMfm17EJ/22v4lUOawLk7Z9jZS7ZsXOw959WUL5tMXBhnu9DE7Ts1gYXw
	 7FptFjIh8CgTL+L0zT5Z3mfQE3XKAV0EwFThbdMWM/Qz7+OonqVfi3ZmrxJf93tctK
	 vVQD2S1tNcGfIStHMuXGIxf57/Z0RhIhMXiYShT8Vcn3q1vdLuZXgjIbJ7It1wIaSS
	 /h4/bbHnLEI54HgilCf5BRDDV9s0IvTn/6kTbtaZ+2Ii8/DBpFvleYHmNbW6rlDVr7
	 tur5pFL1g0RXg==
Date: Fri, 06 Nov 2026 01:49:55 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add FocalTech FT3683G touchscreen driver
Message-ID: <Lbhn9qT1jCJXASc7tr1mwU9G6_y4_hDlUU8szqyg9cv21pGC_6Pq62qzjty6yrFkL8ML2e5LMrGFEO6YKpid1DMQ5WB04X4Nzs8Ivl35tXc=@pm.me>
In-Reply-To: <auo7GvY0Ufq_7DTn@google.com>
References: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me> <20261030-focaltech-ft3683g-v1-2-38b2f941b039@pm.me> <auo7GvY0Ufq_7DTn@google.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: f0dcd921516e46b4a168f58b8e2fb4015b657f59
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 3rd, 2026 at 3:02 PM, Dmitry Torokhov <dmitry.torokhov=
@gmail.com> wrote:

> Hi Alexander,
>
> On Fri, Oct 30, 2026 at 05:27:15AM +0000, Alexander Koskovich wrote:
> > +
> > +struct ft3683g_data {
> > +=09struct spi_device *spi;
> > +=09struct input_dev *input;
> > +=09struct touchscreen_properties props;
> > +=09struct regulator_bulk_data supplies[2];
> > +=09struct gpio_desc *reset_gpio;
> > +=09struct device *dev;
> > +=09struct mutex spi_lock; /* protects tx_buf/rx_buf */
>
> In what cases will there be concurrent accss?

None (yet), carried over from downstream for firmware updates, etc. Will dr=
op for v2.

>
> > +=09u8 tx_buf[256] ____cacheline_aligned;
> > +=09u8 rx_buf[256] ____cacheline_aligned;
> > +};
> > +
> > +static int ft3683g_spi_read(struct ft3683g_data *ts, u8 addr,
> > +=09=09=09    u8 *data, u32 len)
> > +{
> > +=09struct spi_transfer xfer =3D { };
> > +=09u32 dp =3D 4 + FT3683G_SPI_DUMMY;
> > +=09u32 txlen =3D dp + len + 2;
> > +=09u16 crc_calc, crc_read;
> > +=09int error, i;
> > +
> > +=09guard(mutex)(&ts->spi_lock);
> > +
> > +=09memset(ts->tx_buf, 0, txlen);
> > +=09ts->tx_buf[0] =3D addr;
> > +=09ts->tx_buf[1] =3D FT3683G_SPI_CMD_READ;
> > +=09ts->tx_buf[2] =3D (len >> 8) & 0xff;
> > +=09ts->tx_buf[3] =3D len & 0xff;
>
> cpu_to_be16p()? or put_unaligned_be16()?
>
> > +
> > +=09xfer.tx_buf =3D ts->tx_buf;
> > +=09xfer.rx_buf =3D ts->rx_buf;
> > +=09xfer.len =3D txlen;
> > +
> > +=09for (i =3D 0; i < FT3683G_SPI_RETRIES; i++) {
> > +=09=09error =3D spi_sync_transfer(ts->spi, &xfer, 1);
> > +=09=09if (error)
> > +=09=09=09continue;
> > +
> > +=09=09if (ts->rx_buf[3] & 0xa0) {
>
> What is 0xa0? GENMASK()? Something els?

Not sure, downstream doesn't say. I tried to find a version of the driver t=
hat
had this named but they all just check these magic bits. Since I can't say =
for
sure what it is, didn't define it.

I guess I could put that in a comment but "idk" as a comment might be ehhhh=
.
I added some logging to see if it ever even happens, did some reloads,
suspend/resume cycles, various touches and only fired once, and the CRC als=
o
failed too so can probably rely on the CRC? Right now it seems redundant
and I can't explain what its checking.

Can just drop in v2 unless you'd rather keep it.

>
> > +=09=09=09fsleep(FT3683G_SPI_CS_DELAY_US);
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09crc_calc =3D crc_ccitt(0xffff, &ts->rx_buf[dp], len);
> > +=09=09crc_read =3D ts->rx_buf[dp + len] |
> > +=09=09=09   (ts->rx_buf[dp + len + 1] << 8);
>
> get_unaligned_le16()?
>
> > +=09=09if (crc_calc !=3D crc_read) {
> > +=09=09=09fsleep(FT3683G_SPI_CS_DELAY_US);
> > +=09=09=09continue;
> > +=09=09}
> > +
> > +=09=09memcpy(data, &ts->rx_buf[dp], len);
> > +=09=09return 0;
> > +=09}
> > +
> > +=09return error ? error : -EIO;
> > +}
> > +
> > +static int ft3683g_read_reg(struct ft3683g_data *ts, u8 addr, u8 *val)
> > +{
> > +=09return ft3683g_spi_read(ts, addr, val, 1);
> > +}
> > +
> > +static int ft3683g_check_chip_id(struct ft3683g_data *ts)
> > +{
> > +=09u8 idh, idl;
> > +=09int error;
> > +
> > +=09error =3D ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID, &idh);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09error =3D ft3683g_read_reg(ts, FT3683G_REG_CHIP_ID2, &idl);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09if (idh !=3D FT3683G_CHIP_IDH || idl !=3D FT3683G_CHIP_IDL) {
> > +=09=09dev_err(ts->dev,
> > +=09=09=09"chip ID mismatch: expected %02x%02x, got %02x%02x\n",
> > +=09=09=09FT3683G_CHIP_IDH, FT3683G_CHIP_IDL, idh, idl);
> > +=09=09return -ENODEV;
> > +=09}
> > +
> > +=09dev_dbg(ts->dev, "chip ID: %02x%02x\n", idh, idl);
> > +=09return 0;
> > +}
> > +
> > +static irqreturn_t ft3683g_irq(int irq, void *dev_id)
> > +{
> > +=09struct ft3683g_data *ts =3D dev_id;
> > +=09u8 buf[FT3683G_TOUCH_BUF_SIZE];
> > +=09unsigned int x, y, id, event;
> > +=09int event_num, i, base;
> > +=09u8 protocol;
> > +=09int error;
> > +
> > +=09error =3D ft3683g_spi_read(ts, FT3683G_REG_TOUCH_DATA,
> > +=09=09=09=09 buf, sizeof(buf));
> > +=09if (error) {
> > +=09=09dev_err_ratelimited(ts->dev, "failed to read touch data: %d\n",
> > +=09=09=09=09    error);
> > +=09=09return IRQ_HANDLED;
>
> Why not IRQ_NONE?

No particular reason, downstream does IRQ_HANDLED so copied it. Will
switch to IRQ_NONE in v2.

>
> > +=09}
> > +
> > +=09if (!memchr_inv(&buf[1], FT3683G_FW_INIT, 4)) {
> > +=09=09input_mt_sync_frame(ts->input);
> > +=09=09input_sync(ts->input);
> > +=09=09return IRQ_HANDLED;
>
> I'd do "goto out".
>
> > +=09}
> > +
> > +=09protocol =3D (buf[1] >> 4) & 0x0f;
> > +=09if (protocol !=3D FT3683G_PROTOCOL_V2)
> > +=09=09return IRQ_HANDLED;
> > +
> > +=09event_num =3D buf[1] & 0x0f;
> > +=09if (!event_num || event_num > FT3683G_MAX_POINTS)
> > +=09=09return IRQ_HANDLED;
> > +
> > +=09for (i =3D 0; i < event_num; i++) {
> > +=09=09base =3D FT3683G_TOUCH_LEN * i + FT3683G_TOUCH_HEADER;
> > +
> > +=09=09event =3D buf[base + FT3683G_TOUCH_OFF_XH] >> 6;
> > +=09=09id =3D buf[base + FT3683G_TOUCH_OFF_YH] >> 4;
> > +=09=09if (id >=3D FT3683G_MAX_POINTS)
> > +=09=09=09continue;
> > +
> > +=09=09input_mt_slot(ts->input, id);
> > +
> > +=09=09if (event =3D=3D FT3683G_EVENT_DOWN ||
> > +=09=09    event =3D=3D FT3683G_EVENT_CONTACT) {
>
> Could be written as:
>
> =09=09if (input_mt_report_slot_state(ts->input, MT_TOOL_FINGER,
> =09=09=09=09=09       event =3D=3D FT3683G_EVENT_DOWN ||
> =09=09=09=09=09=09=09event =3D=3D FT3683G_EVENT_CONTACT) {
> =09=09=09...
>
> >
> > +=09=09=09x =3D ((buf[base + FT3683G_TOUCH_OFF_XH] & 0x0f) << 8) |
> > +=09=09=09    buf[base + FT3683G_TOUCH_OFF_XL];
>
> get_unaligned_xx16()?
>
> > +=09=09=09y =3D ((buf[base + FT3683G_TOUCH_OFF_YH] & 0x0f) << 8) |
> > +=09=09=09    buf[base + FT3683G_TOUCH_OFF_YL];
> > +
> > +=09=09=09input_mt_report_slot_state(ts->input,
> > +=09=09=09=09=09=09   MT_TOOL_FINGER, true);
> > +=09=09=09touchscreen_report_pos(ts->input, &ts->props,
> > +=09=09=09=09=09       x, y, true);
> > +=09=09} else {
> > +=09=09=09input_mt_report_slot_state(ts->input,
> > +=09=09=09=09=09=09   MT_TOOL_FINGER, false);
> > +=09=09}
> > +=09}
> > +
> > +=09input_mt_sync_frame(ts->input);
> > +=09input_sync(ts->input);
> > +=09return IRQ_HANDLED;
> > +}
> > +
> > +static int ft3683g_power_on(struct ft3683g_data *ts)
> > +{
> > +=09int error;
> > +
> > +=09gpiod_set_value_cansleep(ts->reset_gpio, 1);
> > +=09usleep_range(2000, 3000);
> > +
> > +=09error =3D regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->suppl=
ies);
> > +=09if (error) {
> > +=09=09dev_err(ts->dev, "failed to enable regulators: %d\n", error);
> > +=09=09return error;
> > +=09}
> > +
> > +=09usleep_range(2000, 3000);
> > +=09gpiod_set_value_cansleep(ts->reset_gpio, 0);
> > +=09msleep(50);
> > +
> > +=09return 0;
> > +}
> > +
> > +static void ft3683g_power_off(struct ft3683g_data *ts)
> > +{
> > +=09gpiod_set_value_cansleep(ts->reset_gpio, 1);
> > +=09regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> > +}
> > +
> > +static void ft3683g_power_off_act(void *data)
> > +{
> > +=09struct ft3683g_data *ts =3D data;
> > +
> > +=09ft3683g_power_off(ts);
> > +}
> > +
> > +static int ft3683g_probe(struct spi_device *spi)
> > +{
> > +=09struct device *dev =3D &spi->dev;
> > +=09struct ft3683g_data *ts;
> > +=09int error;
> > +
> > +=09ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +=09if (!ts)
> > +=09=09return -ENOMEM;
> > +
> > +=09ts->dev =3D dev;
> > +=09ts->spi =3D spi;
> > +=09spi_set_drvdata(spi, ts);
> > +=09mutex_init(&ts->spi_lock);
> > +
> > +=09ts->supplies[0].supply =3D "vddio";
> > +=09ts->supplies[1].supply =3D "vci";
> > +=09error =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
> > +=09=09=09=09=09ts->supplies);
> > +=09if (error)
> > +=09=09return dev_err_probe(dev, error, "failed to get regulators\n");
> > +
> > +=09ts->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +=09if (IS_ERR(ts->reset_gpio))
> > +=09=09return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
> > +=09=09=09=09     "failed to request reset gpio\n");
> > +
> > +=09error =3D ft3683g_power_on(ts);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09error =3D devm_add_action_or_reset(dev, ft3683g_power_off_act, ts);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09error =3D ft3683g_check_chip_id(ts);
> > +=09if (error)
> > +=09=09return error;
> > +
> > +=09ts->input =3D devm_input_allocate_device(dev);
> > +=09if (!ts->input)
> > +=09=09return -ENOMEM;
> > +
> > +=09ts->input->name =3D "FocalTech FT3683G Touchscreen";
> > +=09ts->input->id.bustype =3D BUS_SPI;
> > +=09input_set_drvdata(ts->input, ts);
> > +
> > +=09input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_X);
> > +=09input_set_capability(ts->input, EV_ABS, ABS_MT_POSITION_Y);
> > +=09touchscreen_parse_properties(ts->input, true, &ts->props);
> > +
> > +=09error =3D input_mt_init_slots(ts->input, FT3683G_MAX_POINTS,
> > +=09=09=09=09    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> > +=09if (error)
> > +=09=09return dev_err_probe(dev, error, "failed to init MT slots\n");
> > +
> > +=09error =3D devm_request_threaded_irq(dev, spi->irq, NULL, ft3683g_ir=
q,
> > +=09=09=09=09=09  IRQF_ONESHOT, "ft3683g", ts);
> > +=09if (error)
> > +=09=09return dev_err_probe(dev, error, "failed to request IRQ\n");
> > +
> > +=09error =3D input_register_device(ts->input);
> > +=09if (error)
> > +=09=09return dev_err_probe(dev, error,
> > +=09=09=09=09     "failed to register input device\n");
> > +
> > +=09return 0;
> > +}
> > +
> > +static int ft3683g_suspend(struct device *dev)
> > +{
> > +=09struct ft3683g_data *ts =3D dev_get_drvdata(dev);
> > +
> > +=09disable_irq(ts->spi->irq);
> > +
> > +=09input_mt_sync_frame(ts->input);
> > +=09input_sync(ts->input);
>
> Why is this needed? We do not do that in any other drivers.

Otherwise if a touch is held when it enters suspend, it'll stay active
afterwards. On suspend core only releases BTN_TOUCH, not MT slot.
Though, I guess this should probably be a core fix and not here?

Also looking at mms114, they do something similar for their suspend:

static int mms114_suspend(struct device *dev)
{
...
        /* Release all touch */
        for (id =3D 0; id < MMS114_MAX_TOUCH; id++) {
                input_mt_slot(input_dev, id);
                input_mt_report_slot_inactive(input_dev);
        }

        input_mt_report_pointer_emulation(input_dev, true);
        input_sync(input_dev);
...
}

Will also address the other reviews in v2.

Thanks,
Alex
