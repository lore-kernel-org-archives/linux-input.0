Received: from e3i491.smtp2go.com (e3i491.smtp2go.com [158.120.85.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702C4E73D8
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013389; cv=none; b=iSVDYlIFZMqMlIetubaxhuytEsBX+KFG9scs739glA7tQ8dnegGXTS6ef6Y1MWySwXNzJqEDbedSb2nWifbWjceFYdwy3ExXKdq+4VsgrGDoTpJvNBIsTCqq2Nxy2zBmMqOF5UEQ9mfbyZcxeRLoZXWJehSdyno5+ivkhZbcDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013389; c=relaxed/simple;
	bh=fngXC7lgpUnXEi4onVVu/b/uD1YFFBdkY+MSr0dIkpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiFlJ23ycBwljtMZt7Zp1m6DrS4KZSW3Blk/1vyGjvMADDrD8QN7T3K98Vv+PEdhCiJPQ/+3yZKxzPT23Yrzp21YYUNtmeY0QC8h1oyXWtXOcnWAPoa7I1LCxbeXCopSvBX2O1Q+KY+CkplXLRP0CtuIf5m0ScwwtP87PzU/Tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev; spf=pass smtp.mailfrom=em1020969.fkr.dev; arc=none smtp.client-ip=158.120.85.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1790013159; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=mW9HJEvCMULkvoto60bp8qOsfgJWX894wKqY8BXR+Ms=;
 b=NJQC3RAtTjS5CKleCBAUaKaseXRPnvRKD9lh2hrjsftGADmrSvpiE4g4j119Tdlde4HRh
 GLoW0tBGwFCxheYe7faEuGsl53LPDw2BrrS+EXjpKvXlcuSQlFbW5PSE8CjgPxZGNU2Uk5N
 4t1Wcot+aY2J1ePU5jLb4xc0giSMsMFHUeYsyy8zzJibTzGMiOTY8tHxVg6D57JREneG9ve
 8esKi5W5a0w2PptzkzKxN3C6n1BnZP7Ow2fWLkg8CYxb3yCoH7Kw+nfYndk16rN3P9xzrA1
 fTML5s1H0w7yDz2XC7cMRdXS5vvl9HwsQ8BGo0+MzdzBHcfrGD542cGUMK5Q==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1x8iBw-AIkwcC8xzM1-KReL;
	Mon, 21 Sep 2026 17:52:37 +0000
DKIM-Signature: a=rsa-sha256; bh=mW9HJEvCMULkvoto60bp8qOsfgJWX894wKqY8BXR+Ms=; c=relaxed/relaxed; d=fkr.dev; 
 =?utf-8?q?h=3DSubject=3ASubject=3ASender=3ATo=3ATo=3ACc=3ACc=3AFrom=3AFrom=3ADate=3ADate=3AMIME-Version=3AMIME-Versio?=
 =?utf-8?q?n=3AContent-Type=3AContent-Type=3AContent-Transfer-Encoding=3AContent-Transfer-Encoding=3AReply-To=3AIn-Rep?=
 =?utf-8?q?ly-To=3AIn-Reply-To=3AMessage-Id=3AMessage-Id=3AReferences=3AReferences=3AAutocrypt=3AOpenpgp=3B?=
 i=@fkr.dev; s=default; t=1790013156; v=1; x=1790445156;
 b=VRHFyCuPcMIM2qcA6JZvqz7pgOo/COL/QaQ/x8GkS4yLo3eto/DOmKuj59XWeRGdvkGT5zv8
 5SKZvJSp+5w5uXlVvGTNKIA6jvZx75lDHAz3IvouJ7xM05wTtekuQ9oCYGSwR49nOVfhdf5sXHC
 e1GJ9R2vltCISK8pClqFJxZTNMPjtiuqe/WCiAKN4jPj+bFNvp0MHlw1u9h/KHWcwhAQyjKxMtB
 yntFYNKypkz27WiZ2jP/AkDIj9XVSk45eH958vaCHL4yyVaHQJbI+CHxYunM9g4v04om5ZGz3P4
 7KUcHrV2Bwfz5lf25feXbDtdWYNE1hgWXZiG5fyuIgdzw==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id fc545454; Mon, 21 Sep 2026 17:52:36 +0000
From: Florian Krischer <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Krischer <florian.krischer@fkr.dev>
Subject: [PATCH v10 fixup 0/2] ASUS Transformer EC: SL101 keyboard
 event/response fixes
Date: Mon, 21 Sep 2026 19:52:35 +0200
Message-ID: <20260921175234.3137985-1-florian.krischer@fkr.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969sLnWE1pO7r
X-smtpcorp-track: Fps2ZhthoHl-.ovlwD5h-s0Z5.vozocgw6gmu

Hi,

I tested the v10 ASUS Transformer EC series on a physical ASUS Eee Pad
Slider SL101 while bringing up its built-in sliding keyboard.

The EC probes successfully as:

  Model         : ASUS-EP102-DOCK
  FW version    : SL101-0202
  Config format : ECFG-0001
  HW version    : PCBA-EP102

and the KBC child creates an AT Raw Set 2 serio keyboard, but v10-style
behavior does not complete atkbd initialization on the SL101.

Real-hardware tracing exposed three details:

1. The SL101 EC event window at 0x6a uses the 8-byte SMBus block reads
   found in ASUS's downstream driver. The generic 32-byte event read
   loses the keyboard command-response path on this device.

2. Keyboard command replies can be valid OBF-only packets without
   KEY/KBC set. Non-AUX, non-SMI/SCI OBF responses therefore need to be
   routed to keyboard serio0 so PS/2 ACKs reach atkbd.

3. The observed keyboard reset response is:

     03 09 fa aa

   where 03 counts the following status + payload bytes, 09 is status,
   fa is the PS/2 ACK and aa is BAT success. v9's data[0] - 1 payload
   count matches this framing. v10's data[0] - 2 drops the BAT byte.
   The fix keeps v10's upper-bound check while restoring data[0] - 1.

With these fixes and the SL101 EC DT node at 0x19/0x1b, Linux 6.18.45
boots through RAM-only kexec and the physical sliding keyboard works.

The two patches in this fixup set are intended to be folded into v10
patches 2/7 and 3/7 respectively, rather than merged as a competing
driver series.

The dependent Tegra SL101 DT patch is prepared separately and should be
submitted after/with the EC binding dependency.

Hardware:
  ASUS Eee Pad Slider SL101
  EC model ASUS-EP102-DOCK
  EC firmware SL101-0202

Validation:
  - physical keyboard PASS on real SL101 hardware
  - cleaned MFD and serio objects compile successfully
  - cleaned SL101 DTB compiles successfully
  - checkpatch: 0 errors, 0 warnings

Florian Krischer (2):
  mfd: asus-transformer-ec: use 8-byte event reads on SL101
  input: serio: asus-transformer-ec: fix keyboard response framing

 drivers/mfd/asus-transformer-ec.c             | 19 +++++++++++++++----
 drivers/input/serio/asus-transformer-ec-kbc.c | 16 +++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

--
