Received: from outbound.st.icloud.com (st-2003j-snip4-11.eps.apple.com [57.103.77.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D502495036
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856530; cv=none; b=VFJh+oPheCBw9Ch7/b0HFs2JHd2iY6BGXjOuQHGwcntKrqbXP8eBus6K8w8i6/n8B0/FAr1vtMJIRTOU0Upi2XguAGFfCJBAdlbAtPMKFzKTAIvfzQ3Mk1kYKH3w5sanbPaB6MjAl1gfePPV/t1BRZJCnFqHu3JQKXkLItyfjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856530; c=relaxed/simple;
	bh=M7rSi+2KbeMwEjD1ZQGlZAFijZT6ByDYgo6kfq/6+rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDXemKmEMiLNQhbWYSbIQNjBXFg3DqrnXiefMFklNAaGE6ibsMyP+1EKp0Bwh8nOtbXEfzc2maf/jjetEJaWDiO4P9+vVyXKfV1V03yI/4O7rpuJAa3rSAfXcwto6ZoVcM0PpkaXByc9RXg2Un92t5qDTywFHe6qFq2Y1dj3E/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=m+D9neR5; arc=none smtp.client-ip=57.103.77.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="m+D9neR5"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 10FC4180025D;
	Thu, 27 Aug 2026 18:48:46 +0000 (UTC)
X-ICL-RepId: 01a0448d-9e8a-76ce-9936-1ee754d4d7db
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhKCkMGWgdeCEEGQwZcEhVdRVAAWgpIClY4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgtQUR1fAgoERwRbF0YDU0VBBBcRUAFYHlZeWhdeTUcfQE1iSQFaGVscQBdKbk1TDw8ZWhRcGFNFUR9UWF4EU1YOQglKBV0PWQVBAUwEXAJFA0MPQAdeGlofE1QVUhdNBHIZWhRcGFNFUR9URhMZThtXTVAbXwJCDw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1787856528; x=1790448528; bh=AY1PvJv/NiI5ZWOLCs+J8c9RaT1aAiXk5qxhEqF9e+M=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=m+D9neR59AOUM6hF1L53lF45eDag/tfJ1SA2oVlXDowQnb9gx8t3VftELtgQBlSFRCj7oCkFlO7wT4MlNaZ0Um1AZrXsg2GUwRdiKzOn/p8JeuGgKZzj3RAvirOT3YGWT5OukuK1dapsBR+Aa2mDdqnGsDo1BD8Eo8eEFJnnsOjxsqRumd3nu8HsNxi4etwTxPit/Ck4IFoEnhAEILJoTV7rSkxHV1clXo6C5qH4nU1fzCxMwEK59uCjtbD9lAj+8LXfi8aEAaOthLJWSNtUnCLziShoL/LskWPCi3xc0chf7/YDXklRhjdVfMmD/pGbx0dgMLvFb37ZnBCd0ZJ99w==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id 23F291800093;
	Thu, 27 Aug 2026 18:48:46 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: wse@tuxedocomputers.com
Cc: tgu@tuxedocomputers.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	hansg@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: Re: [PATCH v4] HID: generic: add LampArray support via hid-lamparray helper
Date: Thu, 27 Aug 2026 13:47:15 -0500
Message-ID: <20260827184715.136843-1-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8c05e11f-6e63-420a-996b-5d1986743ce7@tuxedocomputers.com>
References: <8c05e11f-6e63-420a-996b-5d1986743ce7@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yWMg1Pmc4_Ug2znEY9ELlduVnyo7qWyC
X-Proofpoint-ORIG-GUID: yWMg1Pmc4_Ug2znEY9ELlduVnyo7qWyC
X-Authority-Info-Out: v=2.4 cv=Ver6/Vp9 c=1 sm=1 tr=0 ts=6a90868f
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=lmYTH-fKyJQKsRdkMMYA:9
 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=mGzgV76dRlD25_95D0kX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1OSBTYWx0ZWRfX4aec7UA1+Z1Z
 DeccKSVgjtkP6MMQAX7ZZz7k+Cl5T+zZACQohnW2Q8k3mAZOrOPxJfcUdF8OwGTRs4lAkefy/cY
 50SUWZ8ALt/XLd+ahXa6bnN56SGgHBsWfT74+hWtjnrNPrPwxY9doy9x73WgkibY93+I4/qwBiN
 obIBA6tnDeMW3FCtDscU6biDMx5OYZqPy6Jow++ZJhBek+wZjSgFe8jdG1Ub9O/qn4sLL+Y4UvR
 90gkO8aI9GEybI5nSXPQNjohllbmfIHJ95NKfRGyb92MU4PEy4wNYM6mUJTrl9mTozA/g4BsNfv
 0PL+WnTfMbHJ5R9FK/ba9qgwl49I3i5C3Og+XGKJiyYaAxE3TLd+5THTMesUYI=
X-JNJ: AAAAAAABu9ZYQKFVD+WanbIY7zMsEGnU54RFrvK/eUY83NbeYJNRC9zJmZJeQ6Yt/BP6GMRX95sp2gKOygY7VKtj4yjKAf3sWlspajBEdKg2OHJdtVnARWBs9xbCzxL6Z/nlG8OLB6ZDGrWTEyuN429BpsDkbMdlsk3aBRPS5cFoTq9zrf5m9DCTbxTGjf83IdoQNuR58Vc4x9A8K3YIM6xg2N4+goUTVizCcLsYRialHuoMmVZhfRSh3tPu/przBYiYvMFKfQrMfQfSilUaARCew9JLoRUz1GwAWK89xD2ysEYbgawaM0EzjVt2MVegCsO+9VW+oHprYLQ/aqBeJFHOCs47QQd1xVaHWc9OeWabYYTZCAPuqoPQ76oDrIHiGxg+snkmzNnk40YTxrXmojxalmGykWSgqhQzgveMLuZOtPxM7ToViF6d/zWSq73mNtpTotXNF7rINk34SCZqUdn0H/6zvFjjUGpIK1Cih5uYmnMR7socTf/bapgQy14Dp6iXb1/A8H3b7O+hQrH5bjmbixrv63e5ZX4l8yLdY1ldNW/RZV/WC4+iKPh2rv4dHBlxnklRBsTblGrjaFDAicVuDqliTJP7oOKoZU2lXQDTlWLYY4j6wBlDb3FIth43sYDkLQykuTyczKB18sHjhNtcWpAq4LJv2aGCm3PItq0Jp0gsgByF3RIdrJd5HwXKMMpJ4wxgLYvRcKIuzXTqZyKrdTVsqv0P73p0PdT9Dw4YIvPq0CFd0KncURkAbkdE3b1UOUE0tALV+Djq6q5a4mLel3pQetUAj1RGg+9SC4h0B6OqDMX2NycTlRiQ0ST2VMXiac0UX52icZkmp75GR1tfmiqpAAgdN5wu3/bzeSRr301RuvflkfH/OmwGMvTqnumhE/fxqog7z0JRSIXYnhuV0m7EnJntRt6gsV9/NrD/nmnMHUggyGNVtiFi/GVKKqq1+KDJNMjHYWQ1CfzEsQbQUzfAJ+9
 rHgQ5L5tfZgsexlo2lLjS257/m+bnznhKXfLb4r/EmdQSUEh+YBXJ8qlOo0H0msJrVWjbl3HyBtLdhYyz0+Ev/YNsO0bwwD+4biT2ZgrjBu2uItnw8nvhRjEkKgaqzBwq8XB53ckcAHe5EzbZFFfNXd5gubLCTaK/z0i0UC1Bw52QASUlTrPcT5R2gM7QciDA55N/CYrora9UErWG22wE6tgSvOLnWahp/YRko38hSQDZ56mfpnQ/LbHzi2mWzs88R6ZoimtaZy1YwN0JOKRCaXtieONHw4JLIHpJ

Am 25.03.26 um 11:35 schrieb Werner Sembach:
> as Tim went on to other endeavors, I'm taking over this patch. I have
> yet to test it myself, but i was already in the feedback loop while he
> was writing it, so I'm not unfamiliar with the code.

Hi Werner,

I recently got a new laptop (Acer Predator PT14-52T) with absolutely zero
support for any RGB outside of Windows 11; while studying the behavior of
the Windows driver, I found out about LampArray devices and so I ended up
landing here.

This laptop has 2 LampArray devices: a USB attached keyboard (05AF:767A)
and an I2C ENE controller (0CF2:5130) for 3 zones in total. The original
motivation was power draw during s2idle; the lights would stay on and
constantly draw power. I measured 12.35W drop to 2.84W when I
blanked the lights and measured with a simple usb power meter, so I've
been working off of Tim's code for the past little bit.

Getting full support required touching most of the driver:

 - Multi-zone support with individual zone states instead of a single
   monolithic zone taking every device.
 - lamparray_read_lamp_count() used hid_hw_request(), which is
   asynchronous, so the value was read before the transfer completed.
   Switched to hid_hw_raw_request()
 - lamparray_parse_update_report() would bind to the last HID_LAIP_LAMP_COUNT
   (usage 0x0003) parsed rather than the first, so LampCount ended up
   being on the wrong field. This has been fixed by binding the first match.
 - Added suspend and resume hooks, including an autonomous mode refresh
   on S4 that my laptop needed
 - use_leds_uapi=0 now leaves the LED class devs registered, but ignores
   all writes rather than unregistering them.
 - Also added ABI documentation since it was missing previously

About half of the driver changed, so I don't think it would be easily
reviewable as a delta from v4.

Would you prefer that I post it as a v5 with Tim's patch as a base, or
should I just send you the changes that you can add to your own version?
I don't want to duplicate work if you already have a v5 in progress.

I have hardware in front of me so I can test whatever is useful.

Thank you,
Cristian Mazzotta
