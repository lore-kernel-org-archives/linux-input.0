Received: from mx0a-0046e701.pphosted.com (mx0a-0046e701.pphosted.com [67.231.149.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133A3019C3;
	Thu,  4 Jun 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584500; cv=none; b=nmgvq4JF3HPddsI5LU6qFusfF+WBAeSG8PqVaMKr7hu6dma+KVmvB7BMxJlK9j95uYJ6/iX9SzHWXUxxwxomfM2aoj7xwdY7l1EIHCADPty4OHwaFcjxRLr7foKzEARnR9Xzn5ZXqhYA/4RA4j8tw3kEnq6yn1iuL5900XryoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584500; c=relaxed/simple;
	bh=RbLZDymbM43CQVMhvDRhT42I4f600tPN+/juBdzGuv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g21CBD4G5k2tE3/6rKJ71kbeYKjgYCSppx9Rg9XQvs3Fb3bgdtahdW01lMGzFbqGEJcM41Wc5OoMQ1+pUeo0mUqzMW9QGHXKZJU2M1CZ8XXUTacYqA4UHEGKM9GtKM0xhYrZoGr6yyEcmyIZJmkCS6Xt95jn8zvNjrF4zC1ic9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=XpI3Ln2d; arc=none smtp.client-ip=67.231.149.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="XpI3Ln2d"
Received: from pps.filterd (m0341554.ppops.net [127.0.0.1])
	by mx0a-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6546a5KY518581;
	Thu, 4 Jun 2026 09:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=beeWq
	Q0hxI0eg6n5fhsT/kZau9PKcyMFwfTI9cfpy5A=; b=XpI3Ln2dy9bLDSoYFLijl
	P3kIw405YGPBqT1ix4bvBKJvgWJBF7GNwLBBNoaiF5PLg4mEpo7rTXI+cH8lEeYt
	4RYE9fF9Y8qJLOWzb18hWUVbLM1YX3PYE3OF08oP9q1qP9TfGcFY0fpkc2dt7AhW
	5a5WEKJ+T2ReJvY5v5yymvXtctPhgS3jKCPldgz3i4JtZmXEOeDANs2jER5Ybg2O
	MJkWPSIedilKpHeRqWcm2e4iSoVFPCsMsFFn70hPonBzgKH5UY4r1R5nGUiBsU2f
	Qqzg2JN1DD7GrYYnAkp/9/fVXvZ0LZhTkuMkxk6i5YJ0EQmHRh0TKZBR/O4fj0Xt
	w==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0a-0046e701.pphosted.com (PPS) with ESMTPS id 4eh8wsywgt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:25:27 -0500 (CDT)
Received: from localhost (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 5A271432DD;
	Thu,  4 Jun 2026 09:25:26 -0500 (CDT)
Date: Thu, 4 Jun 2026 09:23:25 -0500
From: Danny Kaehn <danny.kaehn@plexus.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v14 2/2] HID: cp2112: Configure I2C bus speed from
 firmware
Message-ID: <20260604142325.GA1355442@LNDCL34533.neenah.na.plexus.com>
References: <20260520-cp2112-dt-v14-2-b1b4b6734b6f@plexus.com>
 <20260520174401.BDE571F00893@smtp.kernel.org>
 <ah6MeSb-NlzniiCA@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah6MeSb-NlzniiCA@beelink>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Feto8lvSUlGz2k8qGvGksnJ8r7mWw3Rf
X-Proofpoint-GUID: AN2x8W7_AuNWXD2Jt2NIYMA5XWoajtvs
X-Authority-Analysis: v=2.4 cv=euvvCIpX c=1 sm=1 tr=0 ts=6a218ad7 cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=3mNqGZouX4yY8cy_l5z6:22 a=c92rfblmAAAA:8
 a=Y_joWELsAAAA:8 a=VwQbUJbxAAAA:8 a=taodae8e8x6o541nS3IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEzOSBTYWx0ZWRfX7fpxuUZWjfyj
 zV+1NY/w10bl2vWFwyR5fwA+/cMFegVz9tXFah1y5LKvXhvq32QbeJI1J97T7/amKbfkMH3EjtZ
 KbFt6hWixJsSHDxwVc33s5o0OwP1NtrgZDPkG6pmZOaVolf5pGEoJLGe2Rw4kQU6a/TzPZfIPM5
 2j2NVUvbu8JZCf2yssvmwgOflp+S7vpqskzakpUp9p9qwTHJrrYeqUngE89tAESzuBx7YC7al3R
 d1UI5nFXdpkPaVYDuVisTWVPqEcwTDVN11Xb+u9aRqJqi+hUhuuf9SXDC9QnPeHKFLZ5U/S/W82
 RgTH3JLj6uyuTKBrx3Y+2nXTz5BsxTsgDoNpQ33u77M/TbhLOIj4mHGySNUxKZKGhSSdJKkgLoh
 eD4/ceWqz9iKToaPyyk05lMgjmoO/l83EqXJo+2fpaQLcMSLOW0QiXWud/yUPmh5ELeqVTfYnIe
 o5g3KTKcbKuWrzxIUxA==
X-Proofpoint-Spam-Reason: orgsafe

Hi Benjamin,

Thanks for the review; will fix the issue pointed out here.

On Tue, Jun 02, 2026 at 09:59:23AM +0200, Benjamin Tissoires wrote:
> On May 20 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > 
> > New issues:
> > - [Medium] The driver silently overwrites custom hardware I2C clock speeds with a 100kHz default for devices without firmware nodes.
> > 
> > Pre-existing issues:
> > - [High] Firmware nodes are attached to device structures without holding a reference, leading to a dangling pointer and use-after-free.
> > - [High] The delayed work `gpio_poll_worker` is not canceled in the probe error path, leading to a use-after-free if the probe fails.
> > --
> > 
> > commit 07ff467e4d8df706a7a27476591cd82570fb8287
> > Author: Danny Kaehn <danny.kaehn@plexus.com>
> > 
> >     HID: cp2112: Configure I2C bus speed from firmware
> >     
> >     Now that the I2C adapter on the CP2112 can have an associated firmware
> >     node, set the bus speed based on firmware configuration.
> > 
> > > diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> > > index e960fc988058f..04379db93571b 100644
> > > --- a/drivers/hid/hid-cp2112.c
> > > +++ b/drivers/hid/hid-cp2112.c
> > [ ... ]
> > > @@ -1308,6 +1309,9 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
...
> > > +	config.clock_speed = cpu_to_be32(timings.bus_freq_hz);
> > 
> > [Severity: Medium]
> > Since use_defaults is set to true, does this overwrite custom hardware I2C
> > clock speeds with a 100kHz default for devices without firmware nodes?
> > 
> > Before this patch, it looks like cp2112_probe() read the current SMBus
> > configuration from the device, only modified retry_time, and wrote it back.
> > This preserved the device's original configured clock speed (which might be
> > set to 400kHz in the EEPROM).
> > 
> > By calling i2c_parse_fw_timings() with an uninitialized local timings
> > struct and use_defaults = true, timings.bus_freq_hz will be
> > unconditionally set to 100kHz if the device lacks a firmware property.
> > 
> > Is it intended to silently downgrade the speed and override user-configured
> > EEPROM settings?
> 
> I think we should fix this:
> i2c_parse_fw_timings(&dev->adap.dev, &timings, false);
> if (timings.bus_freq_hz)
>     config.clock_speed = cpu_to_be32(timings.bus_freq_hz);
>

Yeah, agreed, a good find. The CP2112's default is 100kHz, but
technically possible the bootloader or something has changed it from the
default. Will fix.

> > 
> > [Severity: High]
> > This is a pre-existing issue, but is there a missing cancellation of the
> > delayed work in the probe error path?
> 
> This one would be nice to fix in a follow up patch.
>

(Not planning to include with this patchset for sake of churn, but could
perhaps be fixed separately in the future... I do have a handfull of
other CP2112 patches to send on once these merge).

> > >  
> > >  	ret = cp2112_hid_output(hdev, (u8 *)&config, sizeof(config),
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com?part=2
> > 
> 
> Cheers,
> Benjamin

Thanks,

Danny Kaehn

