Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD663C3437
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496688; cv=none; b=jxFLR8a7HB0Ggu0B7YDMxuwaCfgr9xGh8dIARA0xHHvwk1O5IGLhL98IyzyhaXmTstvkMQclp1qS0kapMaUqMe9XrYkMVlepNvkYo6KwUUi6f1PRX9cJt1hYMDGI6ptyOX2GR6mekku5EdhzVWGhnsTM1//mBhCaAt4bW5ZIf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496688; c=relaxed/simple;
	bh=al/lPrscsdkhin2XtDNnRJXUpM6mAEgF3JBdQMjs9Bo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEfZtOEJDk2c34Vp/vCSjZ8WRujYKPsjJNeGsCMZ0h21Y7XbcW/zmTzDEQRvzchqyC0ebfcjXALSW8dCUoe/PbbH0ve4QvKCCPdNIJgVCpd9beftpAk5KV05d9k0f8MwVReZsg/SpmcHEFJKQrv717OtSLIIPaBx4TzxY4MoCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=kgH85NJI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zqbl9G+H; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="kgH85NJI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zqbl9G+H"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 567051D00141;
	Fri, 31 Jul 2026 07:18:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jul 2026 07:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785496684;
	 x=1785583084; bh=3bNFMVgvMRyK0ybecd7hztcIuqPZlQHy45JF7ao9LxY=; b=
	kgH85NJILUPScWFRwhkzcQ33lDrKTb6KWr5ySyXqQD44BvWdfM271fzzsj/nYl7T
	DmAUG7kieB2+ALej4PQpj+BHHhVTBRcTKr7UWLnU07T//6WkCndRzRxtDWKLvRJ+
	tktDMkNyrMc3f+0jSLRLH5YExChigWWqTYszJwb/mhy3bE6KhqOE7TFHwwXrnmzw
	+xbvllGRMZmMLBH+4UOPPJPUFh0tO4yNwPEv7sl7pqNZhRJuIyQy9yFemHzmZXeg
	LJzBfKdDyG+ra+r7ezIyTYHLL4/him9K6J2BLgm7a/5saOnVu2bgHjDJKJzZHT3w
	Ud8n5N0bZdqOmDeHthlmEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785496684; x=
	1785583084; bh=3bNFMVgvMRyK0ybecd7hztcIuqPZlQHy45JF7ao9LxY=; b=Z
	qbl9G+HZtTAlz08CuFbKf52rx6G9InaI0C0qyLmYjCC+dNIEf+Utlxq82ODFb47R
	/nOS3f7A7hDRv32a0ByH2O4GWAdOj533DGlE5QNlegy7LZ5QzmxD1KF5LWD1N3AW
	Cks16hcoad6+47IztmhAuAPFYpapmQ+NnKYzdcJOoojr018pAbKT1qdqdm7KGpoy
	QhVhmlw411RQO7bdLD3X1IU0y/fRbYYWMWVZvfNO1K6XovjxAZfgCxZwklGyKy1a
	7zoePSlcSuBu7w8+MJdXqC6Pr6vAd8AZNCpbzDNaaK7CIbh6BI+hHvArHO9v07tv
	TNr2/nUGBqg0Sg03nLeWw==
X-ME-Sender: <xms:a4Rsag_TrFfIP0n9kPmtvuKETva97oZT-d96rWaRR7XjGJfTkXxsHw>
    <xme:a4RsajgrmAltBWH7WBD8ByIP9ReomXzSkZ6NkzAe3H7nmXxkFiInzIOJgw2HwrITo
    XDk8Ri8rGGRTWkmFMLryZAnd1_7YKBn_Ic3p7jjjHeY_EZl5XDwnJo>
X-ME-Proxy-Cause: dmFkZTEVHwh2Q7sIL6RRGkTqHJS951CoYEzQQc2n7kGdaPn4qR6tdG5gzCW6l2Ca9x3JHz
    hjKP/W66VokaDav+txDNUQXsWclULyaZQsUS2qkKsS9G1CMfW2caMSNqaoZ4UBpMpy3S4f
    wTNdxAi+OVTYDstuPAJYPlb7u4txtmhT/7o+0dyv44Ejob/gDPMFEwegsb2+OMLoza9EC1
    18j75WBtMME4UHffmJVjHin5miDgLoPr2pF1W9IvAZ03PHJ5Am/o4FFs+XaA7Qk8zu9p8L
    oUvQI2Iib0cgnrjHCtNkRD4WOz8SwWVvdtH65FUXzrd0IQ/TZAWkvC2RLyy5Sl+p96uKMq
    2W7DckS9Y+JP3CViTaeAHUymrLNttW4o44DqMjzhN48nsWhXd63j5Omg3yhfZM86JQ3p/Q
    su9Uw9x9IUuSzb/TmaaQ0oDjEm8jOz6Nsl2DIdIdfJmalQvXdoAvwnZMEhGGBdD6alGRpP
    OBKy9uml+mKeAVizd29IeDJWK4cktjKs4YUisz62IeUdwYFxEz8uMvSeZGdfKw84DvD9Yx
    ciRKBs1K4ZKo6x03jQIozCT3nvV7VFqHCVP/c71+hcdJtJ8uXf9+EFq+yvq3tZ4O48rkNO
    96zdwXEXRIIrgIgJa5JyydCJ7DzNL56H7qt4G/cKK1p6A0dwipqtFjqFixGA
X-ME-Proxy: <xmx:a4RsaoWQCK0tOquXKX06ULji6ocvtUZ62kxdBtjGJZNCSWoSZKFgOQ>
    <xmx:a4RsatR0yH12_eLVEqiH2rPMLRgBa_R3WwLB9gVglyZ8-9SbVg0coA>
    <xmx:a4RsaqkKdXpt8a6MIlsAduoKrzoEUZz9_Li5cIFH1mhxBqik0vLr-A>
    <xmx:a4Rsar6_gv9QJ3znlCi4p1kFvHO2gG2WyiGgkRfZIQLk09jcFsZB-w>
    <xmx:bIRsakrIqObyhAnnRbswk0RQkC8nXvUa5NAUxitdaOlZooIG6iGaJ_Jw>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 769651EA006B; Fri, 31 Jul 2026 07:18:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtQoxBk7cp8s
Date: Fri, 31 Jul 2026 13:17:41 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Rafael Passos" <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>,
 "Benjamin Tissoires" <bentiss@kernel.org>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>,
 "Brigham Campbell" <me@brighamcampbell.com>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
Message-Id: <f1accf74-c527-4c53-9321-84dbcd8fd729@app.fastmail.com>
In-Reply-To: <20260729164928.1138468-5-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-5-rafael@rcpassos.me>
Subject: Re: [PATCH v3 4/4] HID: wiimote: fix uaf when hid events are handled during
 destroy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Wed, Jul 29, 2026, at 6:49 PM, Rafael Passos wrote:
> In wiimote_destroy, in the time between setting WIIPROTO_FLAG_EXITING
> and hid_hw_stop, new events could be handled.
> The new behaviour mirrors hid-playstation's output_worker_initialized
> flag-gate (source of inspiration).
>
> This issue was reported as a pre-existign race condition by sashiko.
> I confirmed it is possible, but very unlikely. It could only happen if
> shutdown is initiated by Linux, and the controller is being used.

`hdev->driver_input_lock` serializes all probe/remove/event callbacks. Can you elaborate how this is triggered?

I can see that external APIs like debugfs and other sysfs registrations can trigger this, but they are deinitialized before cancelling the work, aren't they?

Thanks
David

> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>  drivers/hid/hid-wiimote-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-wiimote-core.c 
> b/drivers/hid/hid-wiimote-core.c
> index 31ee86affc553..067db8b8a56d1 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -92,6 +92,9 @@ static void wiimote_queue(struct wiimote_data *wdata, 
> const __u8 *buffer,
>  	 */
> 
>  	spin_lock_irqsave(&wdata->queue.lock, flags);
> +	/* Do not schedule work if controller is exiting */
> +	if ((wdata->state.flags & WIIPROTO_FLAG_EXITING))
> +		goto out_unlock;
> 
>  	memcpy(wdata->queue.outq[wdata->queue.head].data, buffer, count);
>  	wdata->queue.outq[wdata->queue.head].size = count;
> -- 
> 2.53.0
