Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2D427A06
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784563; cv=none; b=JoChKkhIdpITohM8QMmJXmYZ2XgmnjYUEEm7amdy78YpymNQa8xLkCTBWTzADFKAZd5qF8kDH1bqsWq8D5ozX0MEtq01q8rvUP+defhu95sk7Lh9i5djM/zUK1xd2/qIscS6S8CTZRUQgpnOFULNv9QYstL+Rc1Oo89ybgr9zRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784563; c=relaxed/simple;
	bh=mrO+BsSsNgwnuSX3UaLBRdUdLDlXlA6VHErkX/eArA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebXWbTC8GJrWdc3WXTaidRPnYbrQs8iIRyG5CHLoKCD9Pi+HgtayA0BL5GXiETD0p4645MFI+ic2CXlGPFC3VeFrxSBxra6zNIfzzxL/msmTgtGY79z+NJV4jYA+eQAruGZwlf7D9lob5AeqyxmdCl5eoXdzgJg1sNXn0eR/EsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seFHsTzO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seFHsTzO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0006ea8eso24882051cf.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784560; x=1786389360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1fduvTpD42ESt1oRP9IHFMVMP1Xuv9K5VEBmDDxT20=;
        b=seFHsTzO4KIqP42OzJLSHMVVmYETeqNIrJNdWlRPNl1UYrJj+6X4LDMpECq8rAuIuX
         KcUR5vo2+AZ9eyvDwc3L8idZSoWIYFmnDnqZ/Tk19wGJjVXFq3NixM+eo4dtiIF7355f
         jJh4NxL9RVd6CC62+G+tmbozR/Bqtj0HeXb3LI7S+j5LEf/7j71smqoTs9tKXz4NTCQk
         4RZbBgLXERGnO1mE3zJKTG08mkRhg7SteEx6yUEoui/75xgdZSoekq/GSVxUBuQpcbgJ
         PDXwBNIF+pRXZaq4pjyWhC4jZPPc7saxNsxo7HYauBhRQ487BBiZf0gbKMfs3brPtFBM
         wk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784560; x=1786389360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1fduvTpD42ESt1oRP9IHFMVMP1Xuv9K5VEBmDDxT20=;
        b=KhzSCYrjLZeWAfH+aZiIMSh/jH6doHGGwpcEsM/KAC9I2y29qPzd0MPw0NCeVAXcpb
         VRDWzu/9+Duf3L+i0/tp2kEquPP99JTOjMnoaFf7vUMz6Oz4A5s/adXJeBx0J2F5iliK
         BdOTL4nkEzJWu1q2E7p0BzNduowFm3x+Pywo8B0C7fsmYSe9++WXnoS3b0N60u5Ay67b
         v1tx+kBW31UqMzpNI94w48BquqPqW/IXHOqDmm8+dI66FJbMKDy9phwNZj3Vf0r8bxR4
         i5kF1wks/Se4Donq/mFaK14aiW1djWIVIWPtGC4B8+hLNBDpNhzV9iDbj2wzSPTmwPr1
         ARrg==
X-Gm-Message-State: AOJu0YyQ+h+Bg4rnMWFk1/LjGhfCYbiNLBVaX2ggqPfbrdIL6VTTLG7V
	JsrUpI2qGE4wzJTEFsDiSeTzLtu01E1Trhqcv6RwrZvpXLrlV2sliuKu
X-Gm-Gg: AR+sD10pMOvAfUK+VzMtdHE8b/ehbH4mILCzBLJdLHmijAzkynF1Zv4cQgpH+ceNaEJ
	SjjFJhELXXyBgw29wmJDkW4AVZUjI/2jA3B+YM3p9qd1wd2s60WtfgzxYtiUoPB71jZCZYTvFu8
	UhCC11cTCgR4nHdjC0LzftGNKGnfVa1/7dlJ2zrCcgqZ/+4agwlpIwrTmMKkz1D8Pn48IGq3QLI
	ZQSh+iV9y/aFkK2PXZ6LTAJsYeTPz3qwbCRa110yqBJhlP/tm4HNAp0EFqNP5CHNYZ/q/ZSviYl
	MlELum/oel5Nrp7N9BO/pfW0NO1mWDoDmVm3ZTqtpmPQGdlXS0aj2+XQSj2Oxl8JglH3CBETLQr
	+qdcsxds6pHa1ENuCD5HueRJd2jPNc7U5mk434vtCs2f1OFijVUlnDQjz+4IYjprSJc4RqfWh2R
	g/3P1tYNJ+PD5HpS6ssSIaznjUCIi7S3RGxBttFU1YGRUivTOkDzrh5JzTfVEWMZFOK1ISZ69gz
	40dRVYc7tUrfWCQvGg=
X-Received: by 2002:a05:622a:11d3:b0:517:8d24:64d8 with SMTP id d75a77b69052e-52b566aa82emr208085391cf.13.1785784559571;
        Mon, 03 Aug 2026 12:15:59 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:15:59 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 4/8] HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
Date: Mon,  3 Aug 2026 15:15:49 -0400
Message-ID: <20260803191553.66368-5-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report POWER_SUPPLY_STATUS_FULL when the headset is connected, charging,
and at 100% capacity. It reported CHARGING in that case before.

The charging flag doubles as a power-present signal: the headset keeps
reporting charging while it sits docked at 100%, and clears the flag as
soon as it runs on battery. Gating FULL on the charging flag therefore
avoids reporting FULL for an unplugged headset that merely happens to be
at 100%, which would otherwise hide the discharge state from userspace.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index c54c56db9ddd..7b8f5f2623b0 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -214,7 +214,9 @@ static int steelseries_battery_get_property(struct power_supply *psy,
 		if (!sd->headset_connected)
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		else if (sd->battery_charging)
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			val->intval = sd->battery_capacity >= 100 ?
+				POWER_SUPPLY_STATUS_FULL :
+				POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
-- 
2.55.0

