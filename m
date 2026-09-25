Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAF4EE873
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368594; cv=none; b=Q8lmdOTAGcTJysmW6FH2z7hN68E1NUaLkzB8b5i5vc9fyLOA1eesOaEtpeJnpYh5ILdFhcBDVnKqVHDiyneFrjye/Q7YkyPptzQB16u32p6Zj7oetiny4ZeQbglScnq6r0jxU1Zx6kEUNydW4M/8/E9BYP2GinpknOwU++Fhgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368594; c=relaxed/simple;
	bh=JA1MmlvysdwOS02CEm2fbSKD0SzlpVAbqKq6s8T/mfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qal4fk5QSIEqRqMa8MV/fPcAqsCSqMABZ3ZeYhGzvF6cOhk3hQUCe1Q0UzfUXdiu7K/AbUP6z4enfE5CvExdJV2o9KBAaPCh9EZUgrbChiHP/b9GSaVZT9DtpKQeA/LxXkN2NoQJwB7YLFCI1Y5SA5SjXPFRDmPlyDP630VlGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUQoARdI; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUQoARdI"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so937215c88.2
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368585; x=1790973385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4RNJ5nQR9k5gmyuH0UoJLYl6j03ODsgZ0SnhdOWBbVs=;
        b=rUQoARdIqa7zC5jv8hEpX+gubV1tNKAP/VULSdvg4ONtky2R9Bk6rSfbWJEPfamK4A
         b1fzg38bIjCaXnVivkD0QGNNl4gijLyUIFIJZTIvg0Id8dZsDgyTC16/DzWoULc3O87P
         JcaBhIjwsvcs0wIj01D7sC/OGWUupO5DYVcL8c6h/twInBtbabpygzLoaDHO9MWhALPL
         pJ7Gyk1J6VcfzdVxWae2SrFiRpewXdTndy1GJ8I7J5Qbj0qJkqlKvI94DGjK8532d34I
         ES1v1CzJoglwra7xBNsyijJ4skcl2qwaJSnmMSlOwGRWtsFUx1Futcv1p+UQRkhZ0fzZ
         GGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368585; x=1790973385;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RNJ5nQR9k5gmyuH0UoJLYl6j03ODsgZ0SnhdOWBbVs=;
        b=DcNQe3anr/T1x7iesrKMARB0ezVpIm2uYxojyW+u51Wj72EFrMqcu1nem4k9CRgmj+
         dvNeItpgHwq8xs//HcJZtYJ9irVQfEM+6vmmX4kxTYv2AFvmBRShuqN3zWGreoyh6aiV
         FMuBNoQ1S7GAakLtGArle+702LqXCfD2DzNkHTEHh/AINJdMZ2rETROiMjJjBwr/w/ws
         uvN3nZcvg05KCyrqfTvoLLscCX4YkCsWssrX4Xm1L5v/rBNhHY9a8vtE7XgDhAyv1PQC
         NeLUUnLffvU3oY7TMVZSKPlYs3tb0iLle43xXBGrWkOCuOmRQN7DbUUln62frMji2ozT
         UaJQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4NKq7WveOjp39ORFX7A+by50Vy23z4Iu38KSOknPPc4AnsPPn0qusYdMr4j9Iee2iutg0mB/I7kfQKQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ml5oFZUReRpbIjwGlw8jzz2v2B79axYmRiCox9G5aWP4etBLHy
	+hdRMdQibS6mfU8biZXPnT9BWTRC+zO2pDxo8z1dxZcpy4HiH8sd/ojO
X-Gm-Gg: AYBFou20Iiwy037MJeK4EH3T7JdcJafyARL6wVWPfDJknb9vbh+0MmxZG0lAGNNCt6h
	NzsHrETWx5jEVHfk2cK3bDtWpiO1hHTDgeK8wnQL8HAEv6jKGx7ew8QVrxx5Urrqz6DfnIxMu0Z
	hcq2AEI7Vc9Z3gmL2BACY9z1sF3uK6bSoWU2R9vqFC0lz+vLSz2vQwjB6KReLb9VHpo6zfogR8L
	FygkW7L33pKoKeYULs8pSmGXajs0TzGOtGpdgz17oiE13ij3EzhxrvbxDQpNU+PJI/MgggrTxv4
	tVne6IsU97lZkLve7r7mA9dRU+ycuCZ+oIKzBUYDKQLW3b7VmxAijWbirJ0jWS2vxLykE6tzb5o
	jcHGPQOw4Nse4apq0bVt+qlCgAxm8a0tcrYWtQPsHav4o7Czkp6wxJAnHVonDefz2DZyYMngt+O
	cXKneBwSNZUzBjx/QnOESd+nNCyUryAinRVVTiprXygAlMBT798iq3iN28iT5tORlzVT2nfMZ3C
	L90gOHbGAh9pFbSE0uqZ2XZXVk2Ep8d1HbY+c5XhsWoSec3L6BD0j6gudQ+Z3IHtKD5HQ==
X-Received: by 2002:a05:701b:4346:b0:13e:aa58:89f8 with SMTP id a92af1059eb24-146ce86dbddmr949798c88.15.1790368585236;
        Fri, 25 Sep 2026 13:36:25 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:79e1:2e00:6c01:e929:591c:a76d:ca9c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm8107732c88.13.2026.09.25.13.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 13:36:24 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:36:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_1/4=5D_Input=3A_stmfts_-_w?=
 =?US-ASCII?Q?ait_for_controller_ready_after_reset?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b684b88b-55a6-41a9-a4da-3bca33550164@ixit.cz>
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz> <20260907-stmfts5-v7-1-4a53381cd038@ixit.cz> <arbJrK9zfoO1dGzy@google.com> <b684b88b-55a6-41a9-a4da-3bca33550164@ixit.cz>
Message-ID: <B0EA1BC5-3B3E-4D31-9A37-974E38309C74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 25, 2026 1:20:56 PM PDT, David Heidelberg <david@ixit=2Ecz> wr=
ote:
>On 25/09/2026 21:27, Dmitry Torokhov wrote:
>> Hi David,
>>=20
>> On Mon, Sep 07, 2026 at 12:50:19PM +0200, David Heidelberg via B4 Relay=
 wrote:
>>>   -static void stmfts_reset(struct stmfts_data *sdata)
>>> +static int stmfts_reset(struct stmfts_data *sdata)
>>>   {
>>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>>>   	msleep(20);
>>>   +	reinit_completion(&sdata->cmd_done);
>>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>>> -	msleep(50);
>>> +	enable_irq(sdata->client->irq);
>>> +
>>> +	if (!wait_for_completion_timeout(&sdata->cmd_done,
>>> +					 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS)))
>>> +		return -ETIMEDOUT;
>>> +
>>> +	return 0;
>>>   }
>>>     static int stmfts_configure(struct stmfts_data *sdata)
>>>   {
>>>   	int err;
>>>     	err =3D stmfts_command(sdata, STMFTS_SYSTEM_RESET);
>>>   	if (err)
>>> @@ -593,42 +602,47 @@ static int stmfts_power_on(struct stmfts_data *s=
data)
>>>   		return err;
>>>     	/*
>>>   	 * The datasheet does not specify the power on time, but considerin=
g
>>>   	 * that the reset time is < 10ms, I sleep 20ms to be sure
>>>   	 */
>>>   	msleep(20);
>>>   -	if (sdata->reset_gpio)
>>> -		stmfts_reset(sdata);
>>> +	if (sdata->reset_gpio) {
>>> +		err =3D stmfts_reset(sdata);
>>> +		if (err) {
>>> +			dev_err(&sdata->client->dev,
>>> +				"controller not ready after reset: %d\n", err);
>>> +			goto err_disable_irq;
>>> +		}
>>> +	} else {
>>> +		enable_irq(sdata->client->irq);
>>> +		msleep(50);
>>> +	}
>>>     	err =3D stmfts_read_system_info(sdata);
>>>   	if (err)
>>> -		goto err_disable_regulators;
>>> -
>>> -	enable_irq(sdata->client->irq);
>>> -
>>> -	msleep(50);
>>> +		goto err_disable_irq;
>>=20
>>=20
>> I think the logic is becoming quite convoluted here, and factored out
>> stmfts_reset() does not help=2E How about we make it look like this:
>>=20
>> static int stmfts_power_on(struct stmfts_data *sdata)
>> {
>> 	int err;
>>=20
>> 	if (sdata->reset_gpio) {
>> 		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>> 		/* a short delay before powering up */
>> 		usleep_range(1000, 1500);
>> 	}
>>=20
>> 	err =3D regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
>> 				    sdata->supplies);
>> 	if (err)
>> 		return err;
>>=20
>> 	if (sdata->reset_gpio) {
>> 		reinit_completion(&sdata->cmd_done);
>>=20
>> 		/*
>> 		 * The datasheet does not specify the power on time, but
>> 		 * considering that the reset time is < 10ms, sleep for 20ms
>> 		 * to be sure before releasing reset line=2E
>> 		 */
>> 		msleep(20);
>> 		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>>=20
>> 		enable_irq(sdata->client->irq);
>>=20
>> 		if (!wait_for_completion_timeout(&sdata->cmd_done,
>> 						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
>> 			dev_err(&sdata->client->dev, "controller not ready after reset");
>> 			err =3D -ETIMEDOUT;
>> 			goto err_disable_irq;
>> 		}
>> 	} else {
>> 		/*
>> 		 * We do not know the real controller state (was it powered
>> 		 * off or reset)=2E Let's hope that this is enough time to
>> 		 * initialize=2E
>> 		 */
>> 		msleep(70);
>>=20
>> 		enable_irq(sdata->client->irq);
>> 	}
>>=20
>> 	err =3D sdata->ops->configure(sdata);
>> 	if (err)
>> 		goto err_disable_irq;
>>=20
>> 	/*
>> 	 * At this point no one is using the touchscreen
>> 	 * and I don't really care about the return value
>> 	 */
>> 	(void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
>>=20
>> 	return 0;
>>=20
>> err_disable_irq:
>> 	disable_irq(sdata->client->irq);
>>=20
>> 	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
>> 	return err;
>> }
>
>Thanks, it seems to be better (thou would be nicer if we didn't have two =
branches, but=2E=2E=2E what we can do)=2E

That's that enable_irq() in the middle=2E=2E=2E We could have more "ifs" b=
ut that also looks ugly=2E=20

>
>I added you as Co-developed-by :)

Thanks but I don't think the change was large enough to warrant it=2E


--=20
Dmitry
