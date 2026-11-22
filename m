Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=3.73.157.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373857;
	b=n93T9+sOR7IL63eyIoFXwG2egTFXNZYqChTtlWBMdf4W5qOs1s5xSLaeVDoNkt0xKpIc
	 jUSl1/2yicmix6/Teb2dee+6ZpvW7yF7VV+GAUKHCKyIvZTHhnwji+6dLVqn6itju/QCz
	 FiqfWonedYMlg8QxSVixmYGwuTOsXzz5kYEz3IbuBrbGr2UiBn6f0x/ul34lwC7h6YD8k
	 +CtW8apLq/81Bzi9f1HsNabu8Kw+n/twV5wqRkfIoACFuYbL8ITCJLZ39LzTxjQAscpif
	 y2cJcRlSELu8Vo6Pa3YYH4B9+GFmvnzJ+rYeWrYCkdxDdifk8nO4u1M0uNhWrgf/Ijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373857;
	h=DMARC-Filter:DKIM-Signature:Received:From:Reply-To:In-Reply-To:
	 References:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GvhtcFrzROKGDVNJReJp+gsgJWm75t7eWeztML/Yziw=;
	b=Go7XNB6VQGXL66fR3o83rPCpmdCGnJSWQbB06IpCbl1/Yr7oOwCF7/PhVdgoxyVyKrGx
	 QKyzbIWDOQFu1rgXoC00lFoT6NYgHm6F0dWfweuRX0oIhQdMG7ado9C+/LnXOG/JL32HE
	 r5jinXR/ZpItYDRVlNWSN0lpISZ5kCqXYfEuq4gK/3RxT2jj2yDdb+3R8eKQLG49bvVPz
	 XfVlB8dzK4tQA8Z9eSvhaPRdP0aorZh9WWNLpGpvopwCh+Ii1m1mKziyab0faCIT8iDp8
	 hPbL/nx/TqwH5+lrNotc/oonWCV4lCPvI5JwlC3L7OOj79opoS0IxSbHjcqNLK3QEIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chvaja.cz;
	spf=pass smtp.mailfrom=chvaja.cz;
	dkim=pass header.d=chvaja.cz header.i=@chvaja.cz header.a=rsa-sha256 header.s=mail header.b=atjwXp1a;
	arc=none smtp.remote-ip=3.73.157.52
Received: from box.chvaja.cz (box.chvaja.cz [3.73.157.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49284606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49284606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chvaja.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chvaja.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chvaja.cz header.i=@chvaja.cz header.a=rsa-sha256 header.s=mail header.b=atjwXp1a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chvaja.cz; s=mail;
	t=1795373855; bh=SUkRhnfUUH/4W8k3aPeu+sycb/B+YZmoxmqQHc//Ktw=;
	h=From:Reply-To:In-Reply-To:References:To:Cc:Subject:Date:From;
	b=atjwXp1a4HbrjPMy1taOJ6gV4a2LtfBm3b1MjbUaw4GjwXM9iK2hwULWFBmd8GYwM
	 G03idbyoLTBXG3MTylD4RxwJDjRQ14YwSpkjWnN+2NrRezXHGjutNQfInINMXCLIhF
	 unkfoNXzBcTseTNoPLWIfKu34MKrlGjdd7wIUtTsn7Cj4zQSzSn9vWYP/uAiMrFz8L
	 Gk9Lhmh4auQYgCMl0ZgY7QbcsNNIiUQyU43Rt5tpVNgKLa8rCt5GZhlCt0F5by/vLM
	 tOhmpQrqFFLCzPoAP7gD+ULUOg5dv7s3mk6Cxbg/zvj2iPTDOrI/ap6qaPiBqhFxH3
	 PphG3wctUn94A==
Received: from authenticated-user (box.chvaja.cz [3.73.157.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.chvaja.cz (Postfix) with ESMTPSA id 3B12651C54;
	Sun, 22 Nov 2026 19:57:35 +0100 (CET)
From: Adam Chvaja <agent-claude@chvaja.cz>
Reply-To: adam@chvaja.cz
In-Reply-To: <179529440910.635175.11923305248594163087@chvaja.cz>
References: <179529440910.635175.11923305248594163087@chvaja.cz>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, adam@chvaja.cz
Subject: Re: atkbd: internal keyboard stops delivering scancodes after hours
 of uptime on Lenovo ThinkBook 14 G9 IRL (21UY); EC keeps ACKing, LEDs work,
 only serio unbind/bind recovers
Date: Sun, 22 Nov 2026 19:57:34 +0100
Message-ID: <179537385402.4126149.17049462653942712233@chvaja.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Follow-up with corrected and much more specific data. The failure has
now reproduced three more times (roughly once per 8=E2=80=9312 h of uptime),
and I had a small diagnostic hook run at each recovery.

Correction to my first mail
---------------------------
I wrote that the EC stops sending scancodes. That was wrong. During
every outage IRQ 1 keeps incrementing while keys are pressed:

  outage 1  IRQ1 +32 in 5 s of typing, /dev/input/event2: 0 bytes
  outage 2  IRQ1 +16 in 5 s,            event2: 0 bytes
  outage 3  IRQ1 +52 in 5 s,            event2: 0 bytes
  outage 4  IRQ1 +17 in 5 s,            event2: 0 bytes

(idle baseline for IRQ 1 on this machine is +0 over 12 s.)

So the bytes do reach the 8042 and the interrupt fires; nothing comes
out of atkbd. dmesg/journal is completely silent for the whole outage
window: no "Unknown key", no "Spurious ACK/NAK", no BAT, no
frame/parity/timeout messages, no printk ratelimit notices.
/sys/bus/serio/devices/serio0/err_count stays 0. The input device
stays registered. Touchpad (I2C HID) and everything else keep working.

What the Fn+F1 (mute) key actually sends
---------------------------------------
With i8042.debug=3D1 and unmask_kbd_data=3D1 for a 30 s window, a single
Fn+F1 press produces this byte sequence on the KBD port:

  e0 78   e0 20   e0 a0   e0 f8

i.e. an unknown extended make code e0 78 wrapping a standard KEY_MUTE
(e0 20 / e0 a0), then e0 f8 as the release of the unknown code. atkbd
logs the outer pair as

  atkbd serio0: Unknown key pressed (translated set 2, code 0xf8 on isa0060/s=
erio0).
  atkbd serio0: Unknown key released (translated set 2, code 0xf8 on isa0060/=
serio0).

(getkeycodes: e0 78 -> 0; e0 20 -> 113). The e0 78 pair itself is
harmless and appears ~20 times a day in the log.

Correlation with the outages
----------------------------
In all three outages where I have the journal, the LAST event atkbd
logged before going silent was this e0 78 pair, and in each case it was
two Fn+F1 presses in quick succession:

  2026-11-21 21:02:26.730 / 21:02:26.763   then silence until manual recovery=
 21:34
  2026-11-22 10:02:01     / 10:02:43        then silence until recovery 10:09
  2026-11-22 18:16:32.255 / 18:16:32.753    then silence until recovery 19:09

A deliberate double Fn+F1 (one press held ~1 s, second 0.6 s later) did
NOT trigger the failure, so the hotkey is strongly correlated but not a
sufficient trigger on its own.

Recovery details, corrected
---------------------------
drvctl "reconnect" returns 0 and the keyboard stays dead (no new
registration is logged, so atkbd_reconnect() succeeded rather than
falling back to disconnect+reprobe). Unbind + bind of atkbd on serio0
recovers it immediately. I previously said "rescan" did not help either;
re-reading my own log I cannot separate the rescan from the unbind/bind
that followed 3 s later (two registrations, input23/input24), so please
treat "rescan" as untested rather than failed. Given that rescan and
unbind+bind are the same disconnect/connect path, the real distinction
seems to be: atkbd_reconnect() (PS/2 commands to the keyboard only) does
not recover, serio_close()/serio_open() -> i8042 port close/open does.

What I ruled out from the 6.18 source
-------------------------------------
- atkbd stuck with enabled=3Dfalse after a failed reconnect probe: the
  only command probe sends here (translated, notebook chassis, no reset)
  is RESET_DIS via atkbd_deactivate(), whose failure is logged; nothing
  was logged. And a failed reconnect would have triggered the automatic
  disconnect+reprobe in serio_reconnect_port(), which did not happen.
- libps2 PS2_FLAG_CMD stuck after an unanswered SETLEDS/SETREP:
  __ps2_command() clears flags on every exit path including timeout.
- EC switching scancode set so letters land on silent entries: computed
  over the actual translated table, only 0xAA/0xB6 map to
  ATKBD_KEY_NULL; any plausible alternate code for a letter decodes to a
  different, non-silent key.
- No DMI entry for 21UY/ThinkBook in i8042-acpipnpio.h; no runtime
  behaviour change in atkbd.c/libps2.c/serio.c between v6.12 and v6.18.

Remaining silent path that matches the signature
------------------------------------------------
In i8042_handle_data(), a byte whose status has I8042_STR_AUXDATA set is
routed to the AUX port; on this machine the AUX port does not exist
("PS/2 appears to have AUX port disabled"), so serio is NULL and the
byte is dropped with no log while IRQ 1 is still counted. The same
holds for a platform filter returning true, though I am not aware of
one being registered on this hardware. Both would be invisible to
atkbd, consistent with the total silence, and both would plausibly be
cleared by the CTR rewrite that happens on i8042 port close/open =E2=80=94
which reconnect never does.

I have now left i8042.debug=3D1 enabled (kbd data masked) so the next
occurrence will show, per byte, the port number and flags the 8042
reported, plus any "Filtered out" lines. I will post that trace as soon
as it happens. If there is anything else cheap to record at recovery
time, tell me and I will add it to the hook.

Minor, unrelated observation while reading libps2.c: ps2_drain() sets
PS2_FLAG_CMD but does not clear flags on timeout (unlike
__ps2_command()). atkbd never calls it so it is not involved here; just
mentioning it in case it is useful.

Thanks,
Adam Chvaja
