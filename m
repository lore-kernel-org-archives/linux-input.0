Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977B379C2F
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857078; cv=none; b=C7MyxHHZNOX9U+bQ4G6cb+CvIxiZY+Qf8nsS7J40CPehpr5GqCZxlheAx1zZhhueup/cN8EowxhXDk+kLb39bTCHX3ecGFKza5zb3ui9jCV5Kw84pVHHHx0TXPrtRahoKAIzYZxF6CnczdGgGBAqjz27JOUR6DCMqToHMsF2y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857078; c=relaxed/simple;
	bh=/BeQcwQJYNrXslN9NRGyRDMaaMndwm55+LKP2W2hU8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NE7OTN2te97H5PF5gv7TveTO0E0TBfVRFOXeNHjRIld6jIxZSmToQ8F3yCpVFd9TL+pfPJs9M8Yi9AGjWMQ++9bXRf8equdtct+VdeqgOLCzlm55/DIFurwPV+VQuYjfejoWjhWW+uJIqr2tKPROevojbqiESPwXg8txNuYJ7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St9axJV4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St9axJV4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so88278315e9.2
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857075; x=1779461875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22ZZ7DskZ3gtFB87QcSA0WEWxlxsZu8Cspyfcc0WJQQ=;
        b=St9axJV4X09GLlqu/ZqdWhhBkaRQNV2dG4Jl5sG8fF2OfIj9oPPB5ZPEfdbLvg48Qz
         I8NTHeVyqKm2VQIu75rjiDLwQTZ4+pO1uwhsYf2h0IMzspiOIsRxwXgQITW9CmpGlbLj
         X93b8SvSN5p79DX10rWsDG7pyOcx4TlVPjfnyFEQ6UP8rgh/vC5yhwrYUDtEFjavkPxb
         uzGn56r0APkCX2f7beQ1r9Unp76mBknCKYphv7B2sbttXVp+6uYBnPhLXxx1RjH5g/23
         O43TOjL3O0kvPHfDsFfpct3WxGAU2qy52DGsivf0NpKQB2kiIxH+C7gVxibXpmWFSZPY
         qauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857075; x=1779461875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22ZZ7DskZ3gtFB87QcSA0WEWxlxsZu8Cspyfcc0WJQQ=;
        b=f72HVB9U4Q3aKTR5HC4WwTUkpYTRjWcuAbxLjfzrHHwuexDrhvL2ySKOKK5KSY1EBq
         iTrChj7H1alkzHAcW8PwCzFzSuGfOkZIWdFs43oDszPVF3v/jf9t0NNahd2izaBmWZCI
         eRlqNq7SSpbdxc0CjrUxM4iG/mAPyHexBXTXkEet34fV286HevTCsqJ+9BUdCRuBFoqm
         k992Ir3amC/0g4AJoAsr2V7vpbgoTNuhDSGyb/JcAp2+Nq98MMIlL+FKRdXf2P1fVrJh
         hFmFQ7/rVc65IxmzPyatK0tSQto9Z8i8cdkTp+qtjycvN53zU8OZvVwefkVm0Sp5scaa
         5SHw==
X-Gm-Message-State: AOJu0YwpI2lSACHiIwWOI/Tzksg3rT3yASXkBAFIy6V+6hNIyLv0OkbC
	0qNTLFZS8GmFVrR+Erlhu7vuPYMtZQf+WM4nWtnHB3fC8vZL9/48OlK7
X-Gm-Gg: Acq92OGEUcETA3l0g4fNI78pArJXiMyNDR1vhSA8m4MWakJqDSJsF8BaMi5RnoHCnbN
	U/M4hbBsbPQM8j3nZNoJ+0BCgC7C01FjCUt6mGsel56wOI/mRwz5899AsmTSKYIaKjUE2ekvq+e
	NLBk/uipcv45YSBdpir7HH5/5hFLC5OepfnqJgoezT82YAzoMChGOLutL2+siK93f3Tdw9na2xr
	AmRazD7Ny4XrJSfOSz1Wqwe45h8H3WAIJL7/bOxNO1elXTq7c9tqn2MwJPzZfKH2VFUQi/tXbht
	J+LOLTEIaJblsqVZcsQA1GmS/oCZOAQltdNA9Le68tf5mJ7/HpEs0Ph2vn4mCsorn776XT2ZhXT
	++anlOqmqiupz5MV9eGAijNoKmvIed3nuHPKYgrJEviTKZN2QWk2cwftvWwYVhalnTvrQtxTUCM
	Z6nt4Lh0PKPrWDyct/2srA7/nM+juitMwqDt3LrKeLfnkvnJtgahYIgbKkl+1PaaCAzkvmrBWwN
	1/gh4cXKyS123D8LbCwgrkEpSoCItAsFHJ8xJ53UEbg69EB/mEcVXVFnOr5nwQ8Nfb31w==
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48fe61f2768mr47576105e9.15.1778857074555;
        Fri, 15 May 2026 07:57:54 -0700 (PDT)
Received: from my-vps.. (ip212-227-39-93.pbiaas.com. [212.227.39.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm76096135e9.11.2026.05.15.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:57:54 -0700 (PDT)
From: Louis Clinckx <clinckx.louis@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: lenovo-go: clean up USB assumption
Date: Fri, 15 May 2026 14:57:38 +0000
Message-Id: <cover.1778701376.git.clinckx.louis@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers' id_tables only match HID_USB_DEVICE() entries and the
code freely assumes a USB transport (to_usb_interface() on hdev->dev.parent,
endpoint access in raw_event). Make the assumption explicit at probe and
drop a NULL check that the compiler-level definition of to_usb_interface()
makes unreachable.

No functional change for the supported (USB) devices.

Louis Clinckx (2):
  HID: lenovo-go: reject non-USB transports in probe
  HID: lenovo-go: drop dead NULL check on to_usb_interface()

 drivers/hid/hid-lenovo-go-s.c | 11 ++++++-----
 drivers/hid/hid-lenovo-go.c   |  6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

---
Changes since v1:
 - Resubmitted on linux-input as a quality fix per Benjamin's review of v1
   (sent to security@kernel.org; the HID_USB_DEVICE() id_table already
    filters BUS_USB, so no exploitable path).
 - Added patch 2 to remove the dead NULL check, at Derek's suggestion.

base-commit: 50897c955902c93ae71c38698abb910525ebdc89
--
2.39.5

