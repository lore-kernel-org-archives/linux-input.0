Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119876;
	b=ppY7OOKGIekDut8yB54uz4o12x+z4XzSa3muCsu40n7tbpx5HANORh1k82lQZ5xvNJy5
	 A+uS15sqhplEJRz6UjBskSFX/LxMeVbvdj/cJ9LnYTRrxWmeomcUFV7+gY+ki/kHqdlQ1
	 Nnx+P8K9sZIuvrvVP+33gEU3KVcaczBKx2JL3+MO3vift6//D/0z4AJ+tuUCnfDrIMcUK
	 RNDcC9jtNjAGVBImbM0sXVen2OtavuEIxiCGgEtTEjmCSzxegpesN7ZNtryP6QKQVmnYn
	 32+58JbvHJ5D+4fKIuPcrW38nQTnzbyggN7mQSMy9RgYoaZD1Gm2F0pjdkdEMBLmiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119876;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=S/ldV6nbvWQENE0yLe7aSvZRydDWmDvN1uIHVxA3r3s=;
	b=42P6c+9WmhOtwF4ef7kekR4Q6cleOwzUQwPBrMxIMnfce9CA2ydur3qCIWNZlqc0ZB0o
	 ejawrtHuDc1V7SlnJq4a4YlyvaJJahaZqigLazTziM74xsyb2n/xHBjeMg81VCOD18y+E
	 Uh3c/0bO9ALYHXVnwoNVsbBRNX8B9Z08xorEbaC0h13YkoMITf23PfPLDDNEv6vCfUqSN
	 NnJ94kd68IlydaZ7xFuA43iEttBD+smGIWTwf+tA/Pe9fpeC1GsIZds4rIOLnplDfPMZr
	 Zu3kXwnDkgdhp7LHeZE3B04Wu8PH2PwO94EgIkrhLU4qVGztikt6wu4rgH4xXGSE1CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OSKv/CUq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584D606A33D;
	Thu, 19 Nov 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSKv/CUq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C26C1F000D0;
	Thu, 19 Nov 2026 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119875;
	bh=S/ldV6nbvWQENE0yLe7aSvZRydDWmDvN1uIHVxA3r3s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OSKv/CUqWhD8PeEPx4uUmXrjJ9iidvQLZS5lWhiSbIwoYPHR1IkkL4h+eFcb3LQD3
	 //89t7cLdE03bVdRL68ip+RiIilRfNxNyehPSgJUw5q8LPCY4abG1PrxtomcpMz7C0
	 ogX8wOr3cvSetWqImUaJUa9r52W4X5++7w9ZXDNazEcb38mNTbJ03HUK/TZmIRC2VZ
	 tHEnCw0tQy/DULU3/CpRXdkmBLxDWtch5OKu6KzZqmNDPWc0oCjDhgNpzRnw760q/5
	 N7N9klEGeJzzIZtyxKdiTot+woTQQYNF88rIzpV+pJbwk+zopnqzfQnAKFAKHUtBpS
	 ATFfdeHakq55Q==
Date: Thu, 19 Nov 2026 21:24:33 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: validate GRAPHIRE_BT report length
In-Reply-To: <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Message-ID: <7oq0p682-ps92-9986-2rq9-q8n7n7154752@xreary.bet>
References: <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 5 Sep 2026, Aamir Ahmed wrote:

> wacom_graphire_irq() parses GRAPHIRE_BT reports by dereferencing
> wacom->data at fixed offsets up to data[7], guarded only by the
> data[0] == WACOM_REPORT_PENABLED_BT report-id check. It never consults
> the report length, and wacom_wac_irq() does not pass len down for this
> device type.
> 
> A malformed, malfunctioning or spoofed Bluetooth Graphire (VID 0x056a,
> PID 0x81) can send a report shorter than 8 bytes that still passes the
> report-id check. The handler then reads past the received report and
> forwards the bytes to userspace as ABS_X/ABS_Y/ABS_PRESSURE/ABS_MISC/
> ABS_DISTANCE and battery state.
> 
> On the Bluetooth transports the backing buffer is large and fixed (hidp
> copies into input_buf[HID_MAX_BUFFER_SIZE]; uhid uses UHID_DATA_MAX), so
> this reads stale in-buffer bytes rather than overrunning the allocation.
> It is the same missing-length-check class already fixed in the sibling
> handlers wacom_intuos_bt_irq() (commit 2f1763f62909 ("HID: wacom: fix
> out-of-bounds read in wacom_intuos_bt_irq")) and
> wacom_intuos_pro2_bt_irq() (commit a8e04f3f894c ("HID: wacom: validate
> report length in wacom_intuos_pro2_bt_irq")); the GRAPHIRE_BT handler was
> not covered by those changes. The issue was found by LLM-assisted variant
> analysis of those two fixes.
> 
> Pass the wire length to wacom_graphire_irq() and reject GRAPHIRE_BT
> reports shorter than the furthest offset the parser dereferences.
> 
> Fixes: 387142bb8fcb ("Input: wacom - handle Graphire BT tablets in wacom.ko")
> Assisted-by: LLM:opus-4.8
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Ping, Jason, could you please Ack this one? Thanks.

> ---
> 
> Notes (not part of the changelog):
> - Compile-tested on x86_64 with CONFIG_HID_WACOM=m; builds with no new
>   warnings. No runtime reproducer: per the changelog, on the hidp/uhid
>   transports this is a stale-buffer read, so KASAN is not expected to fire.
> - Found by LLM-assisted variant analysis of the two sibling fixes cited
>   above (see the Assisted-by tag).
>  drivers/hid/wacom_wac.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95..31da8b956607 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -338,7 +338,7 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>  	}
>  }
>  
> -static int wacom_graphire_irq(struct wacom_wac *wacom)
> +static int wacom_graphire_irq(struct wacom_wac *wacom, size_t len)
>  {
>  	struct wacom_features *features = &wacom->features;
>  	unsigned char *data = wacom->data;
> @@ -350,6 +350,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
>  	int retval = 0;
>  
>  	if (features->type == GRAPHIRE_BT) {
> +		if (len < WACOM_PKGLEN_PENABLED) {
> +			dev_warn(input->dev.parent,
> +				 "Graphire BT report too short: %zu bytes\n",
> +				 len);
> +			goto exit;
> +		}
>  		if (data[0] != WACOM_REPORT_PENABLED_BT) {
>  			dev_dbg(input->dev.parent,
>  				"%s: received unknown report #%d\n", __func__,
> @@ -3475,7 +3481,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>  	case GRAPHIRE:
>  	case GRAPHIRE_BT:
>  	case WACOM_MO:
> -		sync = wacom_graphire_irq(wacom_wac);
> +		sync = wacom_graphire_irq(wacom_wac, len);
>  		break;
>  
>  	case PTU:
> -- 
> 2.53.0.windows.1
> 

-- 
Jiri Kosina
SUSE Labs

