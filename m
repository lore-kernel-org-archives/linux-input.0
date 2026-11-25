Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795650252;
	b=Z8uYEc8a9zX6BSit5+NNvWri88wDGJ5Ybn6FTUo/L6CM04/PAAaG1b5ScgEccEtaRFRA
	 +M/LB6rfGJTL8kG3tONbEHU7FQPu/0MVoyDTWrsU9MyRUtwh8fUmQSYgkPfR2M36q8E7z
	 29Pz1AKe0uAaa1KZh2RgSz/ct6w41zLeE09/PMeTVRYE4ILzxO8lUgrOc7m3Fs9+c9e/2
	 rh9G52smpt7XznOU6JodhoODahTWGkqhpCTWM83FTILpVNlp7CGD0YChCynzyARq7UITn
	 sH/eXd0lBFuktKof/qIfNv5UpozJhHNTKBEGfHa0i8A1qx6f+dnMgnB+u6QS4cM64DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3fKVuvxJiitltgDu0Bbbp5nZdcLodGhOo/Sf+vkWL2A=;
	b=jH5/Hr3A+Gh3JOsVDTF19ZNmm/dX6rB9yiDv404M1po8RwU5MzyDYjpth6yB5v3QsPXe
	 5isg//teO8bxBzXbGwafF67m4fO/LKPMIgBs3+PONqDFuQsbChPbFL5r9PQV6KEt0OPLH
	 RbQwVmIySa41hJy3/wkbtyd2z7H5KmmWLbkYHs/MJXp6bCcKOz8fz/dgzSOyStRFFnPWj
	 t6pkzFSpSgBAYHhO9Kj/8KTO5KcPaerxlR5klDpfmRPdviZ4qV2WYUYPefqe/UybSn/Cy
	 RfK/fCUfXLHnlit+piTu6ZuTqu9jjRpZcTIDm3mP7PKSmxhx6NeGNhtedV9tt/Twu6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmJuD6RO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3C606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 23:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmJuD6RO
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-921342fae7eso66999846d6.3
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 15:44:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795650251; cv=none;
        d=google.com; s=arc-20260327;
        b=kUJAwZ22OGW7Pc0mmkicSMkw5jX67hInM8qUNQ82NqbJGL6/kf4lUSTzUArtr6OwRO
         gj43ioaPiqMhgOHsSZcbB147XWwDuiG+D0v1tdpnhFufvPpsncnFHQ7X+cyYzBDRvcBH
         ko9MCLA+g8Pz/zotUGYkMSOU48cvyF+j8DEkTcQjLByFAo+lBDuht3/z/sq4LoQg0riB
         9lFbK7lUuYSbU3VyPtyWFlXr4x/65TrjJ4g0f2ox9fO33GxYX8zQc0qEw4b7EN6JMCjR
         h/w0tV7cEIWRAaVA7Ucc3XcGtTbGWFTKKhucxdSxiQobceoj/DTrw/Jk76X1kIooGWDb
         61Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fKVuvxJiitltgDu0Bbbp5nZdcLodGhOo/Sf+vkWL2A=;
        fh=YYH+6bKgf4oMEhJ7o5GJph7EZAz+IvxznIMAoHDvxKc=;
        b=Q+TLTlpI29JXIgmSufeZoTcjdq6pL6o9a2cgAsKaEj+2XdTQMAkYkv8kngjOf6veAU
         d4xR7hh3Jo8TN5bXZqPfDAPAnyjVcYfVeIjveJi3Td8QDf4JVI6FLKnVFxlc1wLr4Nnz
         KHY1uWqBLiJ0ApHiIBiebr60KkYfuM5rZYayxoQsFWPg1HlR3aIznDgSwTBG+l08wje6
         P4PTuDgpKKVxvfugxkFZTdJU+xyifIERqsvnOWwq2ko5QZykvp3j85O3ei0BA0rIhoJa
         E0uBW74/LOt1qie/Wnuhdo3lJtLYQ3CcH9+JkRxpTHorMLW5yLgnMVDPPwdFKPdvMn2r
         bd4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650251; x=1796255051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fKVuvxJiitltgDu0Bbbp5nZdcLodGhOo/Sf+vkWL2A=;
        b=bmJuD6ROued+2PTNWeWOaIyCpqiQnHn3HWgucB/55qQF38Yijq3MpLKSKbxwUprY/2
         YpYe1CnFRMCA2a79ZnafGiv3RjAat38tRKLc6zQuOW6JMbPvi73VO207I69YWc+9paEV
         WdB3/pZcfAmsgBcqUGtD4245mB50hMJVj/IzYvUxDDmkLe8DDztPSFx11Uf1rqgLOY5M
         jBBlO3XnVhyIFbaYLH7iRGdLzSoywxx+agXjhcLL5cORna9uQ9INbA9ZCaheGJTVRcvb
         wqZ//Ta/IqLOaqIPCYPJ0S6mRo2YyntVWCxvXSkftKD/fHVkEk3iwzoNoLYN5mewiQPV
         HhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650251; x=1796255051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fKVuvxJiitltgDu0Bbbp5nZdcLodGhOo/Sf+vkWL2A=;
        b=tVBi0MKG8o8mA3wWrmKqoxIKON9ORJTYUyVjlRr51H8+/JQqCe1fHTGoUF7+fM7lVc
         L1Jhk5TzPtSC17YylSVYXpyt87LrNwWn5yz7FqpNFr7H5F2QnlLJc5nqkcGqdhSj3hI/
         PgTclXo64RY25Z7fREz+OdLrD1vHVqW0NSq36L1Rv/h8k6CGp8dlD+JSfxDz+H8KuJFw
         axENlAdbAyrtbiwF8lCwI8BXZf9iZboPlKERS2Wkw+aPG2qrJoSntMW4zoLnxM2pICw2
         mrIHflreLxCvy+8QqxFPPu6/mVHchxARAT9yse+NpzOgu+tJVvb3cPHxh5DkOrX0bKvy
         9+Ig==
X-Forwarded-Encrypted: i=1; AL+hErFYcI/00huTzaH85XHaQjWKdyXpStz8sr92LCyZM0pNZy1JUE7bx17w3i3Y5UN6FWlKBqO+og3e1m37EQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+GctvanJetp6Lny1Y+4iQZ8HkrQXm1BoeMoiKW8ovIRB5Gg8Dn
	OdkgvNvjMfUFzAmi6SSg4EoXqsXro+afz5aNMTpAoxobeLJHJz7Nci6unXzKKFUP5YUBZaDRXlU
	75X7MZ+T25zQ+AeuSSfYDY7u+rscDQUs=
X-Gm-Gg: AZFdTZeyell7h6ZzB7OE8EG7Nd3Xdhy9HsQBjCRVBOkrsHXksgwXBLvj9EOHUCR3qCf
	QXSn+ceBz/w5ftzCnV61jCE8ltke/4Lh0Ag0plWm1ZaGTsPV2FiNB/JDHeptqVgmy+NDhBhGs24
	hR8MuCIeyS6YGDs5S8+X0Cu/oq1xe4Giz9kaUgwh6K0I7k9cFnNq+ohRh+VYdqV2EzQAiQuY5ee
	0+e3jZvi3aPqjs1Q4nCLPZ4FcSouauyndp7ohNFbvjP56h8RS/1MM0s7BMUi9gFXsUl1BSabS86
	NTt75fQZM7wO1X5IsKSMHwcJd256TvjMcnQI/003NmiWYY2363FhYBluUVpVyoFVwtOKig/X9bo
	2rTQgF4gxsCnLF6CSiIk+svwrZhHox7K8QjDk
X-Received: by 2002:a05:6214:dc7:b0:921:38d7:3aee with SMTP id
 6a1803df08f44-92138d73c1cmr355955956d6.28.1795650251100; Wed, 25 Nov 2026
 15:44:11 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
 <0291r4so-4p5q-61n5-59qq-761s5s45o2s9@xreary.bet>
In-Reply-To: <0291r4so-4p5q-61n5-59qq-761s5s45o2s9@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 25 Nov 2026 15:43:59 -0800
X-Gm-Features: Aa3M54qop82j0BkkAyG8OqBuWQazFLUjeeuZGk8YRliw8mF8W_6Holy85ZPTGA8
Message-ID: <CANRwn3S0hViGQw_X2sw-MG5FtPXqwLWABOTaE5JNUgaDOw73jA@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Cancel init_work when probe fails after
 scheduling it
To: Jiri Kosina <jikos@kernel.org>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Myeonghun Pak <mhun512@gmail.com>, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 12:29=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wro=
te:
>
> On Sat, 5 Sep 2026, Aamir Ahmed wrote:
>
> > wacom_parse_and_register() schedules wacom->init_work with a one second
> > delay from wacom_query_tablet_data(), and only then opens the hardware
> > for devices with WACOM_DEVICETYPE_WL_MONITOR, that is the wireless
> > receiver's monitor interface and the ExpressKey Remote. If that
> > hid_hw_open() fails, the error path stops the hardware and releases the
> > driver's resources but leaves init_work pending.
> >
> > wacom_probe() then returns the error and the HID core releases the
> > devres group it opened around probe(), which frees the wacom structure
> > allocated with devm_kzalloc(). When init_work runs a second later,
> > wacom_init_work() derives the wacom pointer from the work item, so
> > _wacom_query_tablet_data() and wacom_led_control() read and write freed
> > memory.
> >
> > This is the only work item that can be pending at that point. The
> > others are scheduled from incoming reports, and the HID core drops
> > reports for the whole of probe() by holding driver_input_lock, which
> > this driver never releases early. The neighbouring BAMBOO_TOUCH error
> > path already cancels init_work before failing for the same reason.
> >
> > Cancel init_work on the shared error path, after hid_hw_stop() as
> > wacom_remove() does. The cancel is harmless where the work was never
> > scheduled or was already cancelled.
> >
> > Fixes: a544c619a54b ("HID: wacom: do not attempt to switch mode while i=
n probe")
> > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/linux-input/20260905102908.ADE1F1F00A3D=
@smtp.kernel.org/
> > Assisted-by: LLM
> > Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
>
> Ping, Jason, your review of this one would be appreciated as well. Thanks=
,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hey Jiri,

It looks like the line added by this patch has already been accepted
as part of another commit at the tip of for-7.4/wacom:

ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior
to registration")

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
