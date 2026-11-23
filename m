Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462867;
	b=swTGos3auHQo8lcpkifWdv0taHcOuY5viaRSssadEd65AEZN+GTs3HxXZXAHGYYl1Gjz
	 H0680H9eO+bE3s6ECCLKkAU2Ol3ZtkiAlSZKsA/ZYfdkyR6sEf4g+Tww5DBtD4wx5+XLc
	 wc60YzP4J+s7rNsuxque+R1/IIFWkxwnzc9S0T7/frTIVmhVBH+ZXpJgBemJ97I+0SHIs
	 5UpM6FQT06MbZkIbgQwyDM57lteobl2iE9vmakj+VAuoT7hlEOnbRt8vyj5KEzebQ11Ze
	 WQeUp3T5HJQhPzXNA9VVVo5z2UHDqz76ofi7wBTNYdMgma5JhiguPQqxIoupIPJoAxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462867;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=wPkSieJ5nOiDvrjtKoYhtGwoxz9FoYkfamWj05YqIBw=;
	b=xC6e4eJw7LJ+28+4kNvJKQSBEqLrdt8rAbqiP69rHxfJs0s9rOqgp4dN/tjlbk5/BtOK
	 NSnUxeodh6zKKldESFHbSGd1G3Nd1ITwRXzIOTjDdakfGFpVNocds3FkMPH9BOgWmCNC0
	 K12aBX0yqlo28Lde0O2QXv1xc+hmhcetDKYQGi+9nTniK712Ait04Bs5eAHSFYQ08LbDd
	 ucwZa3IcIgu9L1+sWQf+JOQSPT9Z8JVVhaeoJH8Ko3CYa+Tg7t22ALw7GKwQF6VUujINM
	 7SuR5TX8+O47lHV34ShB7JSUKXQrxgCs09VDEHe4SIbbXm/RiHSQJkb/F+5b3yn/KqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=LdoDXy1d;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF347606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 19:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF347606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=LdoDXy1d
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF3431320F9F;
	Mon, 23 Nov 2026 20:40:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795462857; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wPkSieJ5nOiDvrjtKoYhtGwoxz9FoYkfamWj05YqIBw=;
	b=LdoDXy1doJELuLaZNGRwosbjS+iTqODYP6RUqdk7mhgx5hyV5cpNS9RJeSoXdckZZdPSI+
	4PSP5ACEbazKB9/tTJuQtR0KGIgfeHa2bq3ixGnJvubuLgmshbOZH4vQi+/eEHJquG80hA
	5KP7Vh+z6iEqXMhJOQIxvz561V19gMA7sP7n4Uh7lYLVYZLwRnFYG0GuqL5jULJI825uoi
	cJ98xjm9Or15lBUVXESkpHyky75Tseew289T2EQYinD5KJfIKDuvbeme2M9DsyIZ+z/aXc
	U41Arddh/41NDFzRn4o6+1pUR1/c8x6WjvJzM84/4DlMWhaIoXS6IGXVu6UGbg==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject: Re: [PATCH 1/3] HID: pulsar: keep battery online across RF standby
Date: Mon, 23 Nov 2026 20:40:51 +0100
Message-ID: <ppdppF9HS6q1hX_QC0gzmA@koesling.info>
In-Reply-To: <20261123141542.8128-1-mapengyu@gmail.com>
References: <20261123141542.8128-1-mapengyu@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Aaron,

thank you for the patch.

> Wireless mice using this protocol enter RF standby when idle, causing
> CMD_STATUS to return 0, and may wake on motion without emitting
> EVENT_PWR. Tying STATUS, PRESENT, and ONLINE to battery.available marks
> the power supply offline and absent during standby, causing userspace
> power managers to treat the device as disconnected, hide the battery,
> and stop polling for updates.

I can confirm this. With ONLINE reported as 0, upower 1.91.5 stops polling the
battery and does not notice when the mouse comes back.
 
> Report ONLINE as 1 while the receiver is bound, matching hid-input, and
> gate PRESENT and STATUS on battery.last_read so the battery stays absent
> until the first valid reading and retains its cached state across RF
> standby. Because CMD_STATUS does not distinguish RF standby from
> power-off, the last reading remains visible until the receiver is
> unplugged.

I don't think keeping the cached state is the right trade-off. When the
mouse is switched off, it keeps reporting "discharging" with the same
level for hours, and if it was switched off while charging it would
report "charging" until it is turned on again or the receiver is
unplugged.

>  	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = drvdata->battery.last_read != 0;
> +		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval = drvdata->battery.available;
> +		val->intval = 1;
>  		break;

I tested a variant that keeps STATUS and PRESENT tied to
battery.available and only reports ONLINE as 1: 

        case POWER_SUPPLY_PROP_PRESENT:
                val->intval = drvdata->battery.available;
                break;
        case POWER_SUPPLY_PROP_ONLINE:
                val->intval = 1;
                break;

With upower 1.91.5 the battery keeps being polled, and while the mouse
is in standby or switched off it is shown as absent instead of with
stale values. Could you send a v2 with only the ONLINE change and
update the commit message accordingly?

Thanks,
Nikolas




