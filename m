Received: from outbound.st.icloud.com (st-2003b-snip4-4.eps.apple.com [57.103.77.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE63DAADD
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928355; cv=none; b=eaWqDkrqoPYOyMPRXmu1ZTjF9mhVnQh+70h6LGNFTSPyhYI8k7+koSIgGn250qAfqokgSxh0UPb0sgQxuNnNckDoA9yFaDpl4722L7PDHdP32Me0fiEotAOAKwZkQpmk+lWGwBCArwV4A3o/cFW5Mp+IYB5u+ANBY4ii3dzhuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928355; c=relaxed/simple;
	bh=HRPmZDbQ0/PWOKNBkjC3hPjC9s0q8XiO4uS6kMgC61k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdInT9AZcbMTQOWw4B8xo/RUtHMuMWVElzdObAZ/IECmMeQgPvH/OWWNHb5T5CLGozkIBWiVZKERD6zr45QP0Ydkd69ieSQQJvpMxTXIHd7aAXJTcU0EqLlxcaGvIMWOjWLrA8LxKnMwfqc/Mn9nzGQTHBWyuEva8GJJoYi2roQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=L57var8L; arc=none smtp.client-ip=57.103.77.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="L57var8L"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPS id C343D180011F;
	Fri, 28 Aug 2026 14:45:47 +0000 (UTC)
X-ICL-RepId: 01a048d5-8446-7f2d-b264-97543f9077b0
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAGWxIYXBRcUFgeRhJWDV0JGRhGXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlsTVRdGCRkIXR0ZFVoJClcAQAtOA1UFUwNEDU0CXRlaB0gMSwtABkZRHVQZSRdYK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1787928350; x=1790520350; bh=I8Hd62+LwibdPMA7yFOvXK13B+92WTJ+gOALwn0u1mw=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=L57var8LzK0XO40alS/9CvFvJjoLHNxX8dJu3OJo8xaqGxuIw1XZTpVAjPUpSBkoA6RQDyMHv8/czcI4dMPqBfrkYD++OB4k274PeH8ihJYtMBLJx57bmDnQd4Xh5c3v/bIsuJSn4vCOphxReZEjD6seaTvryQz+Wbbp8UEZS1LrhL29fBbVe6q0VNTHLqAh+CSHBFIUSZFoCwOkZNxxgpR/hE1eC2cU1JWMUax0U+r68OUV6z3o9bdmayvE/D9EHtZWJQa/CLYbriznPk5xy7Wo5a0+VkupC5L4bYrXLIcwXC0iPaJlVbWvTunRZBf4mpeYdkaGizSj3Vo0xCqcgw==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPSA id C48AE180019D;
	Fri, 28 Aug 2026 14:45:46 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: wse@tuxedocomputers.com,
	aer@tuxedocomputers.com
Cc: bentiss@kernel.org,
	cmmazzo@icloud.com,
	hansg@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	tgu@tuxedocomputers.com
Subject: Re: [PATCH v4] HID: generic: add LampArray support via hid-lamparray helper
Date: Fri, 28 Aug 2026 09:45:10 -0500
Message-ID: <20260828144510.158538-1-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d54951b4-8216-49eb-9c3e-ed49ab3d4355@tuxedocomputers.com>
References: <d54951b4-8216-49eb-9c3e-ed49ab3d4355@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mCmttGvAfdC_0FJIWACmmu8z70afe8fZ
X-Proofpoint-ORIG-GUID: mCmttGvAfdC_0FJIWACmmu8z70afe8fZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyOCBTYWx0ZWRfX3zlHd2dbMcoZ
 oUwmATg2+lcVDxXevmZLJOEUY5Rwl7Fi4/IBfXbezPsAwuXJoFQ+2c/s1AT0uu7vLg8aLVEWhb1
 /yWi+0sW8xl2OsCSS/eBPcfENAWG+FeSZXf9bTT/zArO9KrEHI5OpKNSCxh1GWdeYF+svVItsR0
 s8TzscL18g/xJ688xQyL4HIu/nYfi8i/BwZ3oN9VYSaTaYuD4vyxpB5e84j8sURJnDBrL1GVVb0
 aCnsWxuzt289uIuHzD+PlXGxqO9vGJQ7DWDpScAKUhtDT6w6kGQUv1lBBemODlvC3BjvibYn69Z
 dhuerBz7rf+NddWb6Pq4vnA9bda/ebTQEwIIDmq57jFzUqDYcvezw07BfB9vvQ=
X-Authority-Info-Out: v=2.4 cv=Ffc6BZ+6 c=1 sm=1 tr=0 ts=6a919f1c
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hWxEdHQvl6Tn1xj9Vm8A:9
 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=mGzgV76dRlD25_95D0kX:22
X-JNJ: AAAAAAAB8W/lkqfPeXR8/2C97afaZ62u4MmKzowRULh9C+tvXg/gE3nho0DBRw12H6ZCtHrnhY7wqhsSSQw3DmccdDGOvN6VuNySXrlQZ13h6wgKy2OyclEbTgO9aPqXTv+XQOVhMvDrEEv4iguTtWMgRLhk5SUIL1BfXzu2oeMUB3O1krJTI43IS7heRJSe8fJLPqxztGqszbKzZtFMRZhZbz3zMY+zuieflIcJi/F2uraFPHXxkYiiHJCQQyvA8J4mQf18NKxW4xXqorc8IzM4tFhBRJZr49FU+rlG582svg/85Na93/tIW1LvJb6dHjdShIwGRUhjos0rYKna9g2PqN8G6/50tYYaHQMGmyZvHiiBQ/zJcFUp2DsV8IKHPZeBt2wRnzfWju3rWxozNnuUyEjLsKFkS4iECXrdk7ksubk4cUmdfko3JWqlPuTarAJfplKqox0CL/PUWnT6eCvHxfrI4KtM5v+fwmLpYw49B/6vMOlKjPcNvFOX74TKB6Yt/xUSj9mUwPOftr54+2Poajw1uKIl9FLRARsROozQ9u7KRKlIklnSz+zOl8h2BGdAZtgD+csBsXcziI0glU72iQMRgAspnXMBZ/eGfVT1UT5LUDR1TwnVyboObIp3EqUV0r++cHmwT6dVVKsZvdUWiSA79Jzzzsmtx2c4fk/Rask+R0efySeF5maeyY7gUQOrYCC6TtyFTym62ju4D/qgjuDvtGj/spFCgkdrcS3rI4zmaQOXFwRxeujyfqr3Nhkz2f1kSh5twa7eKUE0aH5kwF71HyqX90emq3mWhbJhc4X7/173Ta6NUuHGTog9cl5jSV8l9huH+c+fnWED9gWB1O4k7IFAb91bdj6oEjIUYyDXIiCtDJglLbP23bT0pU/2GZaqI+bUSJetaS3QC6+UzYHeCFh7drGp2tG2jnv1R9V6A5LoDZQTHPiYsfdb6ZQFetItLSb4h2LQstPeid0unJGUEvd
 +PFx3PPGGHdSqCQFlpn3vvEqEdX7Pk1Vbd8fqfyJqnx4U554xHYym5B5DiYvDDRbhdWPDYmSgoJsDBcY+Ans/ZAor5cdNHmGFUeTskyqVUeHVsX2NGCux8KFLBGPviGgv695j0CIWPENmaCxRxF1kBRPuuUyNvV/FbFUo1qjTxdq4olXGMuoPQjty+RJsxVa9eJosZYQgsbEso2ckIaKJbd5FBjyf+fCRpugBdmhZYDzypN9TLsl7yWJCdPT3EoHzyBVl9vtlU+vgqVHwAZM89A==

Am 27.08.26 um 22:13 schrieb Werner Sembach:
> I think it's best for Aaron sending his version first and then you
> reacting on that on the LKML and getting in touch.

Sounds good, I'll hold off and review Aaron's version when it lands.

> Unregistering is important for userspace to know what happens

That's fair, I'll be sure to change that.

As for multi-zone, my I2C controller has more than one
LampArrayAttributesReport, and has 2 zones in effect, so the original
would only grab one of them. I'm not sure if my device is spec compliant,
but my implementation is agnostic to the zone count; I'll come back to it
with Aaron's version. Quirks get an entry for each zone too.

To clarify, each zone in my implementation gets its own dev class where
/sys/class/leds/<hid-id>:rgb:lamparray-<zone_number>
And use_leds_uapi is accessible from both
/sys/class/leds/<hid-id>:rgb:lamparray-<zone_number>/device/use_leds_uapi
and /sys/bus/hid/devices/<hid-id>/use_leds_uapi.

For Aaron when he gets to see this, here are some things I noticed while
testing on real hardware:

1) lamparray_read_lamp_count() reads
   lamp_count_field->value[lamp_count_index] immediately after
   hid_hw_request(HID_REQ_GET_REPORT). As mentioned above, that call is
   asynchronous, so the read races the transfer and returns stale values.
   On my devices it consistently returned 0. hid_hw_raw_request() with a
   heap buffer works.
2) In lamparray_parse_update_report(), usage 0x0003 is not unique within
   the Lighting page, and the switch has no guard, so lamp_count_field ends
   up bound to whichever match the parser saw last rather than the actual
   LampCount field. I added a simple guard so only the first one binds.
   Whether the first match will always be correct is an open question
   however.
3) Both of my devices need the autonomous-mode disable re-asserted on S4
   resume; without it they come back in firmware-driven mode and ignore
   SET_REPORT.
4) I don't believe this would be consistent with all LampArray devices,
   but mine in particular would ignore any change to the lighting that
   was within 4 values of its current state, so consecutive updates that
   are too similar silently do nothing.
5) My hardware did not support reading back the current state of the lamps
   at all, so GET_REPORT and in effect, lamparray_hw_get_state(), can't
   work here. Plenty of LED drivers return the cached value when getting
   the state, which might be the safer default.

Also let me know if you want me to send my HID descriptors from
hid-recorder or similar.

In the meantime, I will definitely go look at OpenRGB's implementation.
I may also work on a driver that will fix s2idle residency on my laptop;
it's part of what brought me here and this is just step one.

Thanks a lot,
Cristian Mazzotta
