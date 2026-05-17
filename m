Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113933164AA;
	Sun, 17 May 2026 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061789; cv=pass; b=QyDmO9KAyjOGgHot79ZtonnxAwWembMIFyGxJnfkg8JxuRqbzwaZOeGz8sKhT8lJhS3i2XDTA/Ml2ylSab/+wCCDVa2WqVtZO9WXkL6oEcMbHMqOnbVsQJbPXS6pSCor0sbSoKKLfbviPr4jJfORfclBsisY9dST65DQmLAiBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061789; c=relaxed/simple;
	bh=N0tSIAuobHoHCWLjqVW5DUoKpRN6POk0hnMoTjT1dhc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TV2MIXqLdXcaegnGk/PuOixLu2ha1//BvGMN0uwj/DVjV+mOTfLdEokE9foHRslHggbBPnOz5J67+ed5RoCQdj5oVfrMFQMHn/bR6h4SI8dNeWPephQFNHpnTGHTIWljj0WdcRJrf5g3nUNc5hgbRqke+Du72a6d9Nm8Ig0W4Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennisfoster.us; spf=pass smtp.mailfrom=dennisfoster.us; dkim=pass (1024-bit key) header.d=dennisfoster.us header.i=mail@dennisfoster.us header.b=Q1ed3MfJ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dennisfoster.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dennisfoster.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dennisfoster.us header.i=mail@dennisfoster.us header.b="Q1ed3MfJ"
ARC-Seal: i=1; a=rsa-sha256; t=1779061783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HGqCQ+vFUBGvyXMT5wR2QVpq9PAW7/yHH2Bp3Bvk9eIWSDRGoW8zpcRSagTqKRYy4U+Xqx8wA3g/U51ZPRf+viVjJFkEaQktToQVb3P8IbaxIh/n8U0GjJS2Q7lgr8/tCb+Sn1Fw7ftemOZz7Z/xSMCLF4jnLmne7gnc7XHB9iw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779061783; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sf3iiHEVS+Ttm0eJ0DGiaLQDocg3QwOjCMBwwzrVTOI=; 
	b=OKiBxsgpc488ATZHWeIsAjObzK89vXt/xygPndhWDpNw5cMWYk5lq7Ll0gxFOiwhc3RcjBv+pm2ttk9gCVywnGZeWNlftouCoowQwlQVXmIpuv0LbUiHpAL3tUfGRqYy5spAELKRS78itM43KqPaZSbzJ518n4ShKqSVnjH50ZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=dennisfoster.us;
	spf=pass  smtp.mailfrom=mail@dennisfoster.us;
	dmarc=pass header.from=<mail@dennisfoster.us>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779061783;
	s=zmail; d=dennisfoster.us; i=mail@dennisfoster.us;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sf3iiHEVS+Ttm0eJ0DGiaLQDocg3QwOjCMBwwzrVTOI=;
	b=Q1ed3MfJznDn8HSwofwDM47ZeoBNhVM0SdPS+/3AnE5ZXXN4iKwENFDeb650vBEI
	zQYcb8PwHpXx0WeWGQbFUhElr7xNMK6R1IGNpoDkWMVtB8Qf5tZnkZfzNVeJxO9sM0t
	lC1NBEI879d0HlyjRx+RIjD+VZHPHER9/BpVsbs4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1779061781918969.0391407459689; Sun, 17 May 2026 16:49:41 -0700 (PDT)
Date: Sun, 17 May 2026 19:49:41 -0400
From: Dennis Foster <mail@dennisfoster.us>
To: "linux-input" <linux-input@vger.kernel.org>
Cc: "linux-i2c" <linux-i2c@vger.kernel.org>,
	"benjamintissoires" <benjamin.tissoires@gmail.com>,
	"jikos" <jikos@kernel.org>
Message-ID: <19e3858758e.779469783489550.85756750264043334@dennisfoster.us>
In-Reply-To: <19e3435bff9.5159b6ff3377555.4429246136901518864@dennisfoster.us>
References: <19e3435bff9.5159b6ff3377555.4429246136901518864@dennisfoster.us>
Subject: Re:i2c_hid_acpi: ELAN2514 touchscreen causes IRQ flood on HP
 Omnibook X 14 (Lunar Lake)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Couple of corrections.

The machine is actually an HP OmniBook X Flip 16, not the
"Omnibook X 14" I wrote in the original - my mistake. Also bumped to
kernel 7.0.9 today; same behavior. BIOS is HP F.11
(03/04/2026), board 8DA1.

I disabled the udev workaround briefly to get an actual rate. With the
driver bound for ~40 seconds, /proc/interrupts went from 18,811 to
1,778,374 on IRQ 20, i.e. roughly 42,900/s pinned on CPU5. Kernel
never marks the line bad - no "nobody cared", no "disabling IRQ", it
just keeps fasteoi'ing.

One thing I missed in the DSDT that might be relevant: TPL1's
interrupt isn't a GpioInt() resource, it's a regular Interrupt()
template with the vector patched in at _INI:

    Name (SBFI, ResourceTemplate ()
    {
        Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, _Y4F)
        { 0x00000000, }
    })

    Method (_INI, ...)
    {
        ...
        INT2 = INUM (GPLI)
        ...
    }

That's why it surfaces as IR-IO-APIC 20-fasteoi rather than something
gpiolib-backed. _CRS picks between this template and a G_IN()/GpioInt
template based on the BIOS variable TPLM, and this firmware ships
with TPLM != 0 so we end up on the APIC path. I don't see a setup
option to flip it.

Probably unrelated but in the same area of the DSDT - this prints
once at boot:

    ACPI BIOS Error (bug): Could not resolve symbol
        [\_SB.PC00.I2C5.TPL1], AE_NOT_FOUND

I2C5 has no TPL1 in this firmware (the touchscreen is on I2C4).

Happy to send the full decompiled DSDT/SSDTs, a fuller dmesg with
i2c_hid dyndbg enabled, or test patches.

--
Dennis

