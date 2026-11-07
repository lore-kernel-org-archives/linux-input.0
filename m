Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794032201;
	b=OH9aCkAjoUIfQKU3KMQCxme2lJId7mtBANn58X2b+t8lmNFQCxZ/2TJZ/PRkBmO1O1io
	 +Rgwgv0pMlTS6pQNP0/WhWKTD40lLJTNJVyaYHLrJdRQReiUspSQ2ySd8W/D2mGTtf17T
	 sKMIxezc+l8tM9j150b31F1tySKuYz1n5+ecAvWciz7P87x8qpT2q5CZZAVvOwjslHhQ6
	 sfE5db2Kvc/JFiMo6x/GKtEFfE1ZXZNcLMSiXeZ4avwF+VDpdtYYjb/XLUtomjlrv/gFX
	 oFbhFMaZOAT9ssj0nCKI//cHIVXdblQoYEnhf7sj60c8X7Fnbck+Xv7w4A/uJXVB9Gw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=CcbEvffJ1YbktP52+IBjEmJDBOSEygU9COTJPwRmZYo=;
	b=oGKwVFqfQQrK7kZZELa+eQwr43gYGL+66UZ4ek7R5GqWWgw1m/9A5w3uLsyhKxer23Ng
	 rR+SKKvOK8olDJ72I9iUr4L2zbtSynWcY5OYCQaZM79Pg3omOGBJiohAwSMag2n0U8Ofa
	 E0l3XzdkCFlsNE+ibY1m3AMfDwy/rLfJRk5+oE4IynMrYQq69hlJWP9XvoFHIZV2Mts6g
	 5GxiwalPQfqtb+1f4Wl6evbJnaZzs4QMGaar1UerxPZ55MssmsYHqjMz1T6KrFbPgCrxU
	 EPIWqYrA6N6jl4fbxQTn8nUSgvJujYVFdnXETzIvg7rlCIcK5v2la5Fq1T5KOawukdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMzMEgbD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73092606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 06:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73092606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMzMEgbD
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6d68de53053so928422eaf.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 22:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794032200; cv=none;
        d=google.com; s=arc-20260327;
        b=M84a2ICrjN7iHsp9C8IJTSM9jzB0NljNJAW+ZfaCD5MVbvqSbANjjjJxojPC+cr3uG
         +gl2JBbUgOU6q1CEpR4xFmTTYgRLdSCy5Hq2oRLn+/pTmHi5EO9u5OmqfQW3npZcud/u
         XFXVQPVZgQEwkje1Uesy/oES39DyVXfwEy0TUFqawoDVUJRKLy6/yPX0GJVI17vGY4Q1
         IjrZ1w3wMqF6G99/3T0RUXR+zcuDWR0zoREzQ2dOo5Wk+xNqsXSd+WLIOIu1+no/GSnp
         db293IjDkD/PwUjaGVaLuSy42MoutS5nSSm9IxmXaAKmCL6S12VYiKsM1+0JLSwZ8Tfv
         wWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=CcbEvffJ1YbktP52+IBjEmJDBOSEygU9COTJPwRmZYo=;
        fh=8WpCMq3m8uVrMbShYQORakEEjbJBqYs0BoY297hCLZY=;
        b=Vr1sGnasvxpYLsQV4eXpG9ylDZ3bKpQuk3ZJ+K/Antt2qE5Z12utMxFUjMUXjAVMbW
         UvQ93yCVCeNiEtxDDwA9sSrBkEmovelXP4QcsLre+XQxTpmVg8fjRFF3+TZ1yr9KFTL7
         bRDmK/IpyqoFhlYuqqBa6VtpQbxcqag8vgPPS1JqrAa1DjKlUjpBGPgrfH2HRa9aHfNk
         et6htvjKEYwf3kW2TFUsnRZiR3PF1eJjwvD181H9PBH3+YF0XvroGbS6A5a9Wt0tRWnP
         vb0s7pdvQtSifKkIKYITTI75XL5vIUoWeGYIhOWyO/bTdILIKtUh5HtPfYWnqKbB/jDj
         umuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032200; x=1794637000; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcbEvffJ1YbktP52+IBjEmJDBOSEygU9COTJPwRmZYo=;
        b=IMzMEgbDuU/dEA5PKn8VAjPY8UhVs0wJQPu/uFjWMu2+wsdQa6sufP7Q+QnhrHVK1v
         CbA89xlsC4QlNY/DHmhqdbrEZCRBbddvJRAaj+Iz6Wu17wCKEg/F3qqzb9OHs0LdUdlw
         +HSb33qX9/f7WJ+2iyD6y6p7Ca/ccDJkK7A6iJ4jHCNuJEPbOiBOEcSa/gEUoXcENmSZ
         W51KyHleJ+BMciSNEUCMFeTBvcXdH+Y5yAUfgnHkAtDoHgECedJKoMK8IBhLeMsaF9vn
         Hagdyk8hZSkRyXlYO6CO6/7yEgraCpDpaoUTV2VTYg6j0yAZ5N84mpOyY92WSUJbzb/A
         HZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032200; x=1794637000;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcbEvffJ1YbktP52+IBjEmJDBOSEygU9COTJPwRmZYo=;
        b=Xl2lwqnISKawjnJh75XtR5n7lcp8s+6UkAgL72qaSi+g2dTErUsv5SWM/RW24yxKJ8
         DWwmM+jITjGkHu6HevLF2UTeST6tnQQgaA+DhlY/asygMeReDhyamfFxjKKbTa8dMjOe
         dulm4FNKfSnT0Lna0dzMjIpoOvpvhUx+a4o3Y/l/T7uLINi62dR30KxMITE+kVokK+BA
         7dH2J+LTInqsSoa2XSBsJdjH4IQLbAQFqwzFlMA85D74w3PvAbzEo33Wue+tPKyP4dZG
         pkRBrLBBKS2064gCMjkBmXenQjrz3nHz3IWjUG0Ghe5uiPNvuYjFBAtb2Wav+GpRenq5
         h8eg==
X-Forwarded-Encrypted: i=1; AKwUvBwwc6x/Xu0D2HhET1QJmPGNtJIcRXdVOjBRYQL631H32ATtdM+JlKiqdpUx5TvlNmFlIe310FqtCnoxvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7C8IAvxohHC74AZKWw9eISKlR3Bl+zdyGqbU7uFBn/GVLB6pl
	epF225/Cp4HOvYJ3iNy1Kxw9zhPru+ONXfBVU/fObQYXOcQ/fo0+eAG07QI1qlqb0AxgHRW0f5e
	mDhO9/iRkLG6fRSWRMyfB7mxn69EPNgU=
X-Gm-Gg: AYBFou1XZJHhmXPBSprXeIWiE/iLYmoh+7awfJ5VlPyyo36t7Vwts1SIVmEPW/CgtPU
	07hnrgM5mBUbHdv7/u/kWyJGh+zjBrlBI74ZwwS6nfrb8HRu98eM///cSoq9mD0e2CII/wScCJ9
	sFx+6ibv6/gr87rJuCQog+Zt6XXWBTtULTv+u2tiOFKe7ol1yiGwu3dfnJ/Spo015tMtXkHXUeS
	WzbOz6iDMHARmED08Tc3FZuzsPrg1hglreKQp7Iz2UeQW6iYK7zV5H55CEh+6j5ASfTU1PilzCn
	3cq9xl8KBJEUNjKAxTdVAcBnUupAkb3FIQst1z3GrbaEicC+PzjtC5qtLofc4FzyrAv0G0eCuy4
	zTqMmRL98rNuSX6GyQ52uE7rb1Ct+pEKFlcw=
X-Received: by 2002:a05:6820:4b8f:b0:6dd:9d9d:50f8 with SMTP id
 006d021491bc7-716e78fc66amr2751990eaf.38.1794032200385; Fri, 06 Nov 2026
 22:16:40 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADYJuTsGK0k5RgLrRjWjkKBO79OFH4Lfj6OtiUOKnOECzeTuxg@mail.gmail.com>
In-Reply-To: <CADYJuTsGK0k5RgLrRjWjkKBO79OFH4Lfj6OtiUOKnOECzeTuxg@mail.gmail.com>
From: Jakariya Abbas <jakariya3460@gmail.com>
Date: Sat, 7 Nov 2026 12:16:29 +0600
X-Gm-Features: AclHuK8iCp1Hu10x6DoiPbm04zgIUus9PDVhhNqbaER5tr09p4iMw5HgXvj9qqI
Message-ID: <CADYJuTt283d74=0=WoX4yTAQT6gRt2NPvfPJ5AsEU0G8Di0aYA@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics - Add LEN205b entry to smbus_pnp_ids for
 ThinkPad T490
To: lovekeshsolanki00@gmail.com, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lovekesh and Dmitry,

I have a ThinkPad T490 with the same Synaptics TM3471-020 touchpad
(LEN205B, firmware ID 3972349).
After the SMBus/RMI4 support was added, I noticed that touchpad
movement and scrolling work, but physical clicking and tapping become
extremely unreliable. A click registers only after several attempts.

My environment:
- ThinkPad T490
- Synaptics TM3471-020
- Tested on kernel 6.18.58-1-lts and 7.3.0-4-cachyos

Relevant kernel error:
    rmi4_physical rmi4-00: rmi_driver_clear_irq_bits:
    Failed to change enabled interrupts!

Workaround confirmed: Disabling Synaptics InterTouch resolves the
clicking and tapping issue:
    sudo modprobe -r psmouse
    sudo modprobe psmouse synaptics_intertouch=0

With this setting, the touchpad falls back to the PS/2 Synaptics path,
and clicking and tapping become reliable.
Could this indicate an issue with the SMBus/RMI4 implementation or
interrupt handling for this particular touchpad?
I would appreciate your guidance on whether this is an expected
limitation or a driver issue that needs further investigation.

Thank you.

Best Regards,
Jakariya Abbas
