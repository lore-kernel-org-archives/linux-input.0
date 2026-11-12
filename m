Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442609;
	b=YfdLvOU5UQ9O8UxL1kOYmGJbXzWTIhSr5KK4kGEt0JJ88m7ZS9IJNFEDd23GWCJknEs/
	 +skNz3qYndB5oPy9hV+nGGgIhKk/4IqaWtFb4lwcOZH3+hFXaDX4wTSB5rQYeaEJmXqgE
	 1ff4weiJJ2dh0MblfnT8HFsd8IP2NV9xYyfU4cliuedIfMwEZP2qMSN63v3Vyl5xF/sWU
	 rk1f45ZBb7lbz1t01KlAqsBpkF77zf9ufFqaNsHgJ0lDVTml7ioAxjgtFGxU0bsOkw9WK
	 3QzDvIYizBueojsfyxywikY0FA0ifcvSL7XpzHNEgI8WgG7DOZQ6htD62SrbQcMH6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
	b=uYN9omyEjv+Bbahq2xf8McPMgePAGlrvRwrbupY9UOxDpzXDo4RaMWwp+uae7KvjDjDo
	 cq4lSLGsj8x8yXBvKAe9/zdhrmBsTvmaHdfF6h4wUkO2VpllyQvJp425eZ7WKlkiPQ/kc
	 S0z6aw8J8KGhM3caYAgyYxjelQfDkJbLFnDqnD7hAX8unvlGRFK/SFypWFLG7DYZr1Pbk
	 UoKZyFTMHKxmHKTM0+mL9UdvPlfI/SeJRwo8ERsnsc7UyLvziSEwmkmPWVP9hkQv4n2Ju
	 nX1qLTMKfXsnCZ+SOZ9wPhWmA0IXKJp6SB1CS/S97oZL6R1Ly25mm9y0K3cIlB9NJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYsbeP7c;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041E606A327
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 00:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F041E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYsbeP7c
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5614238eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442608; x=1795047408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
        b=oYsbeP7czHMN8STkrlG9EQASwg8LH9HR4yZ2fph1J+MVwj0VdxpbC030HkYSoHGdcv
         LrVHhmJ960HrTsEhYE7nZxQ6HZPTBX07IVdDx/nzgkntOiHig5/JwJFwXGWi49sBlWGv
         GEio3pcvQGErbq7nJI2niWk9wbuvLpW0vNB7H6lL4aSmAVm9/eaayucx3b8NS0k381ju
         PuX/mGJUqJathYlYtHcvMeYRHlTQYxqs52aoAGzlan4gDP1+eYHvZ9fzZHdLn5+kq1NG
         hUPRhaJeUto1AQmLisDwksEDttf6arV4JvwftiMOljF+zpf2ZXTD95TiLMZ1wxrs7sCf
         uRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442608; x=1795047408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGexwgK5GsfrYlYAzT+bpSfeXRNUax72AD2f2NRfT8M=;
        b=JP4dyvotUhO5W8pUz4HB1iqbVNGHnuAIcplEJKSNsooxL3NM09tk+puguNgcmUvoY7
         GUGJbgX2sAR7hGyFyjeyP/Iv9XyEu1/gCJVwgNcemPer5ZRfjtigekkpvMpvoMOQnllu
         8BFJF0NT0II2SfHi4P+WmdfsxAbWGot+3ebYbQMaAk9g44tE11iJW/Zyu2jwh22r9NVr
         i6Qc+1m6IXJoEDwMk2au9c4otipkSnTkri+PvmTwcuKdSnMwogQ7pUMr/dthAHrGglLU
         DhGPJpdOezoT1zW8XnucCTt9ScK4zYnw6B4eLsE9h75vKkfJnDupKp5zDIdnVV1/Izbz
         OPpA==
X-Forwarded-Encrypted: i=1; AL+hErFAKRaEAaB+sEDl+GisR5AnzN9twRCsHxirZgMyCGAZSBkLgi5c0Ta7+y3EBG00NYQHEEny8kLUOhvEVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fs4OsZDb6prAsRo5cULqm0K0W0hFZ+bKT/q1Q/j9wPRHA6yxd
	HA+O1ijzTfLAuKY1ZP83gyWXap8GDQcnSyLmGieAMLJnn58gAfJbb0Z2
X-Gm-Gg: AYBFou1dK9TX1NZQ31yww2CKTDZgOcwpGb/Ey9FVZ8j44PwLDzN/+VRF7B3NmEaoW3N
	yYilng+fjFnoaAD/yNZw3MX8Dr2K+OdU/5QHs78jje11fS1TjHOBHP8ZzcsWdwfy4sCdEjf1U+5
	K2aGIqKu9RAox9U/9XYK5HetrgfKFFfOUhHeECGl4WHBIGC/Z1MY7KBNkJjxd5fyvVbZXtD+XI4
	kmzQDGcGRPbkE3XF63zxIULiD1NwBCrALEcuiVW6/G1WYe8bdvaPOIxFV7zdRES/U7IKy7exvez
	VCaZA/gy/A7GAK3NxKndy+NpmCzhTDpGok6SIzhhOq3zFcVzW97Nb2JNYCBN5UoiyNB4jncEqbs
	7NawSKlY4afjJPSuixwe8YAmLUqXFjDVVd295nguqhpHtJs1KziVoxsvP4nPOXpFfgwB9IHB4Xr
	llUKdSycdTy01jHx4obZl3CnlxUIOO+IQd5Z1m8I7J1PB9zfYrVox4s/yLc7DW1tpGmD+GhDmr3
	TQ0VAXQkJXpuhGvgxSm/FyJuam58lVNCvb8Sh+xoZbiRyrLL3vnRHrI6ea4LHbgCTsloyB7N03H
	hk07KSjg42AXFXJ7vgxMSY3rYb1uoBja+9vbZPfpakZedzhz7NOi9UCW9BVWLJb6pUPPPLawU7R
	Cq9dR01Q06XNJ2W+i
X-Received: by 2002:a05:7301:514a:b0:36a:7b3c:4e0a with SMTP id 5a478bee46e88-3768675676dmr4358326eec.24.1794442607773;
        Wed, 11 Nov 2026 16:16:47 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm40492697eec.16.2026.11.11.16.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:16:46 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Shaun Jackman <sjackman@gmail.com>,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
	Florian Euchner <florian.euchner@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xue Lei <Xue.Lei@windriver.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: remove obsolete cm109 USB phone driver
Date: Wed, 11 Nov 2026 16:16:40 -0800
Message-ID: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series removes the obsolete cm109 driver for mid-2000s USB
VoIP/Skype handsets based on the C-Media CM109 USB audio and HID
controller (0x0d8c:0x000e) and drops its module selection from
ppc6xx_defconfig.

The driver was written in 2007-2008 (modeled after yealink) to poll a
4x4 phone keypad matrix and toggle a buzzer wired to the chip's GPIO
pins across four phone models (Komunikate KIP1000, Genius G-talk,
Allied-Telesis Corega USBPH01, and ATCom AU-100), relying on a module
parameter (phone=...) to choose the keymap. The mid-2000s userspace
VoIP/Skype bridge ecosystem for these handsets is long defunct, and the
driver has seen no new hardware support since 2008 while continuing to
attract syzbot crashes in its custom URB state machine.

Furthermore, because 0x0d8c:0x000e is the generic default C-Media CM109
VID:PID and was added to hid_ignore_list[] so cm109 could claim the USB
interface, cm109 actively interferes with non-phone CM109 devices still
in use today: amateur radio interfaces (Direwolf, AllStarLink, SVXLink,
UniPager, Hamlib) have to blacklist cm109 so usbhid can expose
/dev/hidraw* and so opening the input device does not pulse the GPIO
pins and key the radio transmitter's PTT line, while standard USB
headsets with 0x0d8c:0x000e can bind to usbhid directly via the chip's
standard HID Consumer Page volume and mute descriptors once the
hid_ignore_list[] entry is dropped.

Thanks.

Dmitry Torokhov (2):
  powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
  Input: cm109 - remove driver

 arch/powerpc/configs/ppc6xx_defconfig |   1 -
 drivers/hid/hid-ids.h                 |   1 -
 drivers/hid/hid-quirks.c              |   1 -
 drivers/input/misc/Kconfig            |  12 -
 drivers/input/misc/Makefile           |   1 -
 drivers/input/misc/cm109.c            | 940 --------------------------
 6 files changed, 956 deletions(-)
 delete mode 100644 drivers/input/misc/cm109.c

-- 
2.56.0.567.gdb80ae8cd5-goog

