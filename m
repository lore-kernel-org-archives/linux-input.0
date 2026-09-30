Received: from outbound.ci.icloud.com (ci-2006j-snip4-6.eps.apple.com [57.103.90.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC408629
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798343; cv=none; b=f9xQkQl8miJe7w2Up+xYMUvxFX0e7MCx4OcfcHpk7MbCOpSoVxf87wAaPNVMrchI2Img+Ie/AcRmNaM8EwA4SGCQ1ykttTGaUY9e1nSCwggQh/YciZqCEYn5sgw7GnFx6g23iWM0lqzBDF5OvYZ1H6k1Me6lPiy8KVFA58cT4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798343; c=relaxed/simple;
	bh=RGsx7d8YxrSJ957myMpLdIcSFy/GszTr01KBM3l5WF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsCvUZC4QzQb1buXrueKjUCjn9rlQBIwgtFgEXXWMjHORhqAw267Y75B5pFUXda2y5crXO3hBkJCEZZc5lHt/gyGOLx+os7ojaWCBGjLt7706m7DPASf/SNcFs9aX70KJZzcomF1GQqqH0adCegG2qhvrn3JIZzA3IK4fUkifYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=eTDyJp6c; arc=none smtp.client-ip=57.103.90.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="eTDyJp6c"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPS id AA41E18000DB;
	Wed, 30 Sep 2026 19:58:59 +0000 (UTC)
X-ICL-RepId: 01a0f3e6-1e41-72ce-b032-cd2c2001953b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQtNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5CCUoFXQ5YAkEATQtYBUUBQQlJClkARgNdX0tdHwYHch1cVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798340; x=1793390340; bh=zJcTaZYxavhBdn1eQQ/e1H1+1iNILcKE8DTRtC1gIuI=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=eTDyJp6czbidF800GPLXRt5fF6Zy1cQA8G25ox5aoPriprmXxrCW0lZ/Hj93RhFbrsAwbAf18UwL90YUbkJ2jj0Pw84UHMUK0DQ3TzshJN5QGkkLGTVo5YhUVsryxW0hKWXx2+xk3ZkZZQ+fq0/Aw1nTrtt0DmAcjBxjJDoA3UInFovIePnr4zlGjDtseGZSWyE13p5DWE/8Ev1747yiNHq8gFeXMp6I3bp6xekztCqlac8fzPXdfkWwyohcgIS6kQnOd0HRFz2xwxUCvrWP6C0Zwo0yMSq/NzXailau9DK7w1CHDePXQDmi9ljyOnLy9Yn8BHPSlFa/7W/uJwhW5A==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPSA id D8F151800162;
	Wed, 30 Sep 2026 19:58:57 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>
Subject: Re: [PATCH 0/2] HID: winwing: two teardown fixes
Date: Wed, 30 Sep 2026 15:58:52 -0400
Message-ID: <20260930195852.3101947-1-f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790795726.git.f3nr1l@me.com>
References: <cover.1790795726.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Bh_Ef1kIElePAbo-NHAvQvHPZQRE7Y79
X-Proofpoint-GUID: Bh_Ef1kIElePAbo-NHAvQvHPZQRE7Y79
X-Authority-Info-Out: v=2.4 cv=T4+BjvKQ c=1 sm=1 tr=0 ts=6abd6a04
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hCq73as0fieUF7sB1GUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfX5pur28cfAAkw
 8Qqh+OfMIqTpzgpWNOwTd+aB8cGdvmp3S8B1+ZRwW2diMptqln6/M4gooMS/6PM6/16uDYu5RLT
 7Y5djVX21ipR6aW+MTViF0vrfbReihkAs8Sjgblep5T/fjuTFFShn0atChTNMYzt5dI2B35NSbJ
 RdxKG9gVjp/k2lkq4ZkrHGZhV1cjjStRTX1ChRLLUwX44jnaC+EnpmSVe9IFBZaw1ISisPgixqt
 i/QwDw7zFzJeI4UulUyKzKpjHeYbIRtPEl6qjaE3J0bfjjgJ6sDLcEXo3fbd+eKhbrjyqZoLVHy
 3pR2FJN8rKDaTbIrnEMcZcBFX1m/yhoxqXuLZuXCSfwn3rGbxYQuauwsEhyC7U=
X-JNJ: AAAAAAABBghs0Svo0th2mMm2+QWCc0Gqce4mw2bWDqV0eU0rY6uCvczqTw5lQqa97r2XQEHKT/+NSrCaNdoylCom0mXL76LKBv+FhCD4IE18ZpOsTcufmjtbKUWUwYIJvjO0Bx7cpKkiMqSlSJcEgdTzumgV3aRdWNZs1Yadc/0bHoYavSKr4OKBo93syxzKHN56Y3cGs3UErf6QlfvvlzrTVb/CM8JlNcXMVtgzm8jBEgSrzBpfp4LyyYr0lXb42SFJDQEXDwfora7tGJmXnmmYphj4t5mNF5DzlZ6Q1DQrtLoXu6PQB2c3yVAuaUB1acFyFtJ7HfIqdpXxUeEaMkJUm/400fzwR+Qt0Ttv91mDck7vdZcWfehy1Naml/A5KmON31yPHgK7OS7ScqTEfuj1cZhyP/fLhtNzoslNTmZdWD1OJPzA/2f2yrxQn4tMY1PvgrfPBv1ADTcoSFDFTPYXUIvrpxeDNHYtJqRgAcVEhVI3wTeFvFbmbdXLCGq7D66oYwKtivbTsABVCpXMQNx/IDs4N9vPitdxOc2hDP1gC4c86Urlvnr65JaOcAQrYPY0qdnIWBehivEafJprycd93w6sXmmk2+ey1G+f+sVW3DfHYncioOINLz/+DZK3C25VVQ+wcwsQjqegqjESufjXQmwmZZBc1hWa1A1jIUjbpoLo4U+mBL07dH5pxAB7QurUrvpfg0eaGsB8nGgOU9A6uXA6PAVFTuwvW8CVrKLn23Ep5RzDZD5htAh3BHHMI6CY/zOuA+KddyyYz7i3xc/DTh4jKI57IfAK7mlzsZuqO92EDwLy8sq5VSrnQV0khaH1DlzhojNtk+tSNpzH052EHrH+28NgxI8NKjYhhAij8W9IU82O06iPLAKN4AVICmafzlLagQFpJ5unkWZlhh8ugB6Sm9SGgU7Fnc2iamEp2X3q1gDF5qS5VjGzIAWrPevIuCnL1FHwkA5IJ4Lwzyl+solGXfR
 di8RDl/03hXWHwHM7ZbdD62g3bxuz+MoNo8D45WZakz4ioJtKBQBMFCP8gUtR/VBje9vE3D4pngs1LHa3bNh/9AsaLYEO9oepDq+LND8uT87CRBQ2usZupOiOz90Vk6u31vOqb2SUy/LHwr9x+WarXXyJa3IhQE+qamrxLXO8zNxcFyj/qH7oXQ4pHo2L+RrscNC4272mPSJU0zeB5E+NLT+HUmRCZrVGy0ed2kyBq9MQpcvZcz7dFgup2PkH4mj/pu+Qf1ar9cCXa7PjLPdiIoXabPkVXLfdvRo=
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

A note for whoever picks this up: patch 1 touches the same lines of
winwing_remove() as Guangshuo Li's "HID: winwing: remove unpaired
hid_hw_close()", posted on 13 September:
https://lore.kernel.org/linux-input/20260913143909.1589019-1-lgs201920130244@gmail.com/

The two changes are compatible. With both applied, the end of
winwing_remove() becomes:

	hid_hw_stop(hdev);

	/* ...comment from patch 1... */
	if (data)
		cancel_work_sync(&data->rumble_work);

Whichever goes in first, I am happy to rebase mine on top of it.

René
