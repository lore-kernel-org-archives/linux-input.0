Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399280;
	b=xGcNh7FnVnMhLnbmC5QtnZi/We2xc4ldCo3rNnWhrionILgUkjq7O3Yoo0VwHWCPvlyP
	 G69ZyHs+2ncAWgvwqxoLtsidmqDwLLJCMRGWESFpGQby3zg3CEGPXJGS+pi0TQu4n2l5v
	 jCj7pNn9c0R5C5TdVTwMpNrk1lyhQtOnZJZlywkaobapDq6jyEh+hmA382RF4hMb4LY63
	 n/wq6M1qmqPbobJzTnrXXnibNofzpdjzOMW8VkLyTiuVvYjAMeQla+epOxK8sY6UmOZ3C
	 uoRMxUstlwswLKERIcRyDEZrKsX1B3fnjb70df9Yf4sExiwWPGkqMESpht4R6WEqiYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399280;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=Ay7SJra3zfSb8xGZkz2oQvO/gawytCVdK/1RPQUsh/M=;
	b=1LOHPBcPKwRaSvwrIV1a5/ZXrHCXf32uPkZok+yz41qF+crPSyu//Aj0R+Bs74KOaRhb
	 DuZptpTIOlEVX9bETgwqyL0IPeZiKqApbFgYMyRxx+oNBs21kfBy9hdHZcqfvY339jEWw
	 GLLZWlsiZ0olvk/ajIzGy6HyxozrX/usFz4ckqUEbDRsvoLCzF9+2P+XC9Vlonk98PGcW
	 Z40o8jVLwKwkpuDFa3yxjHOFSAb9X2DxDF1o46xlvntBOdTZ3qHtTBZSN55DSBDYUUQ2J
	 3eZpaU3hBPjJnnA0EUlWcPSKhR9btOD1ajOpD1ckt9K64//l76uPSFGf9WkAEmP1FaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=T8QjcNys;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5C606A897;
	Wed, 11 Nov 2026 12:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B5C606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=T8QjcNys
ARC-Seal: i=1; a=rsa-sha256; t=1794399268; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YDkp0yJyKysZzgEcsx/fCCbSG95uz5je/fzM1ly37bwIjoYobrMDabTcin4Ny97lzPaW/aKgnyZA3NCIrtD5IFgeXXRGG66JpK7xwtrx2vqXrnvu/ref7vKeJPY6eNIqzCg0lcCC57zUQsyjI33cbxGETrnYIo1z6RTlwhEhiiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794399268; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ay7SJra3zfSb8xGZkz2oQvO/gawytCVdK/1RPQUsh/M=; 
	b=D1GZiNL/NxBppuDhexRlUg+n7zO5yhk278JF6+e3Yg2ir3GdIR9bPGKW0JrQT3FL6d0zAL5+sAxJKfrztsPYOMQ7lBmUzAJOEwo3LzdDR1RCH3OLd12n2V2fTDT2B2uqcFYpTrKXcvaoKcrtst25bsVGkxbroM8ehhi+pfapWHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=T8QjcNysRDOLruMKxMotlw64X90PuQZL5z+oqYVei/HqGCBKVF2bdQ7N3IWh4Jcr1dfvAzOWbQ28Ec9Vl+ePXww7IhNeq9KoX7L62oZDqM9I9iteFdgOnDMSbPdlEzUVDNX0khybw2Sgy/yvp1Kn7Yiym8nK51m7z+qPYhpN62gMZzPMkWwz9Wgt6oh6CjK07jJk/cRDA/e08T/ARAzf/PixgneGdnh97z4XSxpDgPMDzDj+0Vnto6Az2rb0FuvqrDvr6zxmKc+oMVOT2HJb9pV6l55k/chl5XZhBWfs+vGYsRdcbmCZzMaac+6CZfRXhFnTE9EQcAbUgh0BtLFreA==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=Ay7SJra3zfSb8xGZkz2oQvO/gawytCVdK/1RPQUsh/M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179439926518740.184743715283616;
	Wed, 11 Nov 2026 04:14:25 -0800 (PST)
Message-ID: <db41708e7676697fda99573a31d7747dee112403.camel@rong.moe>
Subject: Re: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7
 Gen 10
From: Rong Zhang <i@rong.moe>
To: Ciro Pedrini <ciro.pedrini@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark"	
 <derekjohn.clark@gmail.com>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede	
 <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>,
 Aaron Erhardt	 <aer@tuxedocomputers.com>,
 platform-driver-x86@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <CAPKD0HduW_atYsz47Nv-9A_88K1B33xENUnZgQAKcH4VHqV9PA@mail.gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
	 <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe>
	 <CAPKD0HduW_atYsz47Nv-9A_88K1B33xENUnZgQAKcH4VHqV9PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:10:28 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Ciro,

On Tue, 2026-11-10 at 17:34 -0300, Ciro Pedrini wrote:
> Hi Rong,
>=20
> On Tue, 2026-11-10 at 22:56 +0800, Rong Zhang wrote:
> > Thanks for working on this.
>=20
> Thanks for looking at it (and for the clear direction, it helped a lot).
>=20
> [...]
>=20
> > Let's take it step by step, and submit a driver for 048d:c197 first. As
> > far as I understood, the driver should be able to handle "hardware
> > brightness (0..9, stored), the controller's own effects (stored
> > profiles)," and "Fn+Up/Down/Space" by its own. (Please correct me if I
> > misunderstood your words.)
>=20
> Makes sense. v2 only does c197, and it doesn't depend on any LampArray
> work:
> https://lore.kernel.org/r/20261110-legion-lighting-rfc-v2-0-845726afb71c@=
gmail.com
>=20
> About your question: yes, the firmware does all of that by itself.
> Fn+Up/Down change the brightness (in steps of 3, and it's stored) and
> the controller sends the new level on a vendor input report. The driver
> only exposes the brightness as kbd_backlight and forwards the hotkey
> changes as brightness_hw_changed. Fn+Space switches between the stored
> effects (6 states counting off). The controller can also read and set
> the active effect, but I left that out of v2.
>=20
> > I am also working on a independent hid-lamparray implementation that is
> > far more generic than Aaron and Werner's series.
>=20
> Something you may want to know for your driver: on this laptop c193
> doesn't show anything on its own. c197 has to hand the LEDs over first,
> with its vendor command 0xAA (07 AA 02 00 00 00 gives them to the
> LampArray, 07 AA 02 00 01 00 gives them back). The controller remembers
> it after power-off, but it only matters while the LampArray is in host
> mode. In autonomous mode you see the controller's effects anyway. So a
> generic driver on c193 alone would register lamps that do nothing until
> c197 is switched.

What if (four permutations):

- c197 sends 07 AA 02 00 00/01 00
- c193 sends autonomous_mode=3Don/off

And what if the sequence is reversed (another four permutations)?

>=20
> v2 doesn't touch 0xAA. How would you like to handle it with your
> driver? A sysfs attribute on c197, something with your autonomous mode
> trigger, the component framework?=C2=A0
>=20

I expect 07 AA 02 00 01 00 acts like a hardware control trigger. It may
be able to reuse the autonomous mode trigger, but it depends on the
answer to the previous question.

In either way, the handover is controlled by the lamparray LED classdev's
hardware control trigger.

My implementation connects the LampArray application to hid-input, so any
HID driver with hid_hw_start(HID_CONNECT_DEFAULT) or
hid_hw_start(HID_CONNECT_HIDINPUT | ...) will initialize the LampArray
application. Therefore, I suppose the only thing we need is a simple glue
driver[1] for c193. The glue driver binds to the component master[2],
pre-allocates[3] the hid_lamparray struct with some necessary
callbacks[4] registered, and call hid_hw_start() to wire things up.

In this manner, you can get rid of the one-driver-two-device nightmare.
The component master and the component can be located in different
drivers and coordinate using the component framework.

Does that make sense to you?

[1]: I will call it hid-lenovo-legion-la

[2]: hid-lenovo-legion (c197)

[3]: Usually it's allocated by hid-input when hid_hw_start() is called.
Pre-allocate it with prefilled callbacks is sufficient to provide extra
functionalities to the HID LampArray application helper

[4]: hid-lenovo-legion passes a device handle along with several
callbacks to hid-lenovo-legion-la. hid-lenovo-legion-la passes some
wrapper callbacks that calls the former's callbacks with the device
handle to hid-lamparray

> Once your series is out I'm happy to
> write that part and test it here.

I will CC you when I submit it. For now let's focus on the driver for
c197 first.

Thanks,
Rong

>=20
> > Please use the component framework (not in your next revision, it shoul=
d
> > only add support for 048d:c197).
>=20
> OK, noted.
>=20
> Thanks,
> Ciro
