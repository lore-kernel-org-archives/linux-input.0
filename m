Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC482236F0
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470954; cv=none; b=OCWS7yxxcaoLZo2NdkLaBzBA+fCzoiUwGZKFFgP8IqSUhGFUjnhbM2/duMmq4ePMYr3WaQ2XWLoYRlwBCC38WXg+lKeeRQNBtf07Tnu/Nnk7IcwJegS3F4ehgUDYYhbQN8a2htjanV7KPjd+Phi/HU/PkkEtDx3omuTNq21wcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470954; c=relaxed/simple;
	bh=x6aSa9JJXzS00dkyGLgJ2CN2Oxn6FztU+snpGmhBF6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAC/Mj0d4LWSjOBa4kW7dNPUJwnJzIlOc6opm37TwNNexE6GeXuy0PHPLdqILRIHN95dJX+Q3seGunhnTlW52w1aOBTOOqNt+ckx+Z0taba151Hfqwoy3X67LfxoeU6bleC5RM/5l6OXRVp4tn8h8jCjEMqc1moLwRHV2VeH3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHp4ltlg; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHp4ltlg"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304e83724bfso3721957eec.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470951; x=1782075751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6pjKUaBePg5CFHf82pDzWAMLUnqsWDn4jvKoQ98y1E=;
        b=kHp4ltlgFRn/uueEVzhRPI0+W+8BKVw1WORhK4tSX2XHEeIclE3tJd0oOpgi9vXkmA
         xvar1OJ45NyKer+LiEg4o8nRayP0KHp7IOsNVBLEN1M9VT2CdSOVqNH0kyyHAq8J3j4s
         1Ht4pbZObi3fHz6YAfM8MS+CJxXIyXkCXztPpYrgxotZ6KAAzuWtOWyoN6EfODsjndvB
         09MHAuEim18ku9qyGId6wvj+RgWnATOFU2GEhO0+QDqc22rS5rj9GPHcl2SeV6EsiA4Q
         5za926dGyCxH95N9dgFR4hTHjrlRMzG+UuRI3d5DxMbr6PwkASox+mBbZ+YHFffQsWp2
         mi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470951; x=1782075751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6pjKUaBePg5CFHf82pDzWAMLUnqsWDn4jvKoQ98y1E=;
        b=NvPSHE3l0UE04YsgEsXWAgC7ZULcG9rJNRrgt5tEKnJMimW1RYyYoCIF/RCnG30Y/a
         onf7q0JOLfovT5FH8EtXtBcmEgY5vyqHfe3n89wjkAda/Cf94OGgGZqpPXehfbAkhjH/
         qHh+0DpVI4ZGvPzgmwEno51IC28gPfuFD2lWK7ArT5dint80TcOqc6swZzULXN9oEWcy
         QEizseuHncugGMhWTzb/gkK1kur2uvzCmKKsaLOCmz/rWikEEeAbuYd37DI1TmukCdc7
         hhqhXFLxhC0bzT6twzAAbhqEfDpoKzBGW9/XiZf7+z/AIGSyxK8phulMSxitQSggPPo0
         Me5w==
X-Forwarded-Encrypted: i=1; AFNElJ9NOpPBnelDlNQl8SCEyH2uY5Qp/SHpKwAjFlzK/kEMaWV+VCrXYOoAa86SgL1w67uXi2rXxbliJTJj7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPB3GJy+S5I5OLbQDmeCIkFfg1G+DO0fqZLfbjp9KsthjfZ1or
	AhD5g2ubuiVwqWPo2s9bJRCj7gmB+f5EtkIvll0n4oIpyQCuB1ZciZd0
X-Gm-Gg: Acq92OF9ibBH6Dv+YdniuG9V9foCiCmF/OY700xwYOaN1igczHHL8zVWfgDxR6uZN5O
	qhQvCkze6AN/GI9fDrCto7lTuBBsyJUMdbBpJKc/Bb3KZXfm3gat1Nw4Q0OTdIe1nGAYohCsSp0
	BmeRPmbsnoI1vs/kFnGadvs2k3O7vLviPMXDBvEFpYlkeadolC0ZvEbQebgb16Fwfj3StsJTRzO
	91avRmamthfbGAX9oeW38SAXT0JizsfFeKN9cwMI45yB8dUD242tAH28UQrUUkRFoZkaSTsDBHL
	rTMJ08eA7MoFz39PNw+QCoKhWeUtJ/161M5w3lOl6wZE0HvoZ1hJwDnFI8wxaZ2/Vcj2W3Y8l1T
	MjxZcjUOOfPJViikgAGpt/jYSnSDOFGc1ZxjNL7g0o4v4cf7Dl5kM5T/mBC2tJlVGL/X87q/UrC
	OuGuxnc3WDIEkOhgDL/0Q1AjWpbUBgEKYLrhInJcm5/Qj/XUBK9hgUv6ln76GrPHn8
X-Received: by 2002:a05:7300:aca5:b0:304:5b0d:489b with SMTP id 5a478bee46e88-30820098d2emr6469710eec.27.1781470951396;
        Sun, 14 Jun 2026 14:02:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5d91:5c26:602d:6a99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea447b4sm11307856eec.23.2026.06.14.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:02:30 -0700 (PDT)
Date: Sun, 14 Jun 2026 14:02:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: hexlabsecurity@proton.me, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - clamp the device-reported contact count
Message-ID: <ai8WppWIAsSKXwFk@google.com>
References: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
 <6f529998-2b4f-441e-88be-fbc4eb33461c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f529998-2b4f-441e-88be-fbc4eb33461c@kernel.org>

On Sun, Jun 14, 2026 at 01:44:07PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 13-Jun-26 04:10, Bryam Vargas via B4 Relay wrote:
> > From: Bryam Vargas <hexlabsecurity@proton.me>
> > 
> > goodix_ts_read_input_report() copies the number of touch points reported
> > by the device into an on-stack buffer
> > 
> > 	u8 point_data[2 + GOODIX_MAX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> > 
> > which is sized for at most GOODIX_MAX_CONTACTS (10) contacts. The only
> > runtime check bounds the per-interrupt count against ts->max_touch_num,
> > but that value is taken verbatim from a 4-bit field of the device
> > configuration block and is never clamped:
> > 
> > 	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
> > 
> > The nibble can be 0..15, so a malfunctioning, malicious or counterfeit
> > controller (or an attacker tampering with the I2C bus) can advertise up
> > to 15 contacts. goodix_ts_read_input_report() then accepts a touch_num
> > of up to 15 and the second goodix_i2c_read() writes
> > ts->contact_size * (touch_num - 1) bytes past the one-contact header into
> > point_data - up to 30 bytes (45 with the 9-byte report format) beyond the
> > 92-byte buffer: a stack out-of-bounds write.
> > 
> > Clamp max_touch_num to GOODIX_MAX_CONTACTS, the number of contacts
> > point_data[] is sized for, when reading it from the configuration.
> > 
> > Fixes: a7ac7c95d468 ("Input: goodix - use max touch number from device config")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> Regards,
> 
> Hans
> 
> 
> > ---
> >  drivers/input/touchscreen/goodix.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index f8798d11ec03..17fcfe45988c 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -1057,7 +1057,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
> >  	}
> >  
> >  	ts->int_trigger_type = ts->config[TRIGGER_LOC] & 0x03;
> > -	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
> > +	ts->max_touch_num = min(ts->config[MAX_CONTACTS_LOC] & 0x0f,
> > +				GOODIX_MAX_CONTACTS);

Should we drop the report if is has bogus data in it?

Thanks.

-- 
Dmitry
