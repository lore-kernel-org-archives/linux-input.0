Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C324279E2
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127801; cv=none; b=u/56wlvtNcSQrA90erPNJGSpdayIaypSV2Uf1mcv3vBbBcGlrI83OHuPFUWBEnsNFMqs8/v+XLFSSALRA0vZsF8psItiAAb2jyhxbViZ0cHkPzvUaP1VNUdig3/tA17e4NzHx0uGreEhULoyC9BFzukEsX9v/QWElXC7j156Sc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127801; c=relaxed/simple;
	bh=+kEIsEkNrgiMDln9QLi9kLSl7tnqi3h+peDwDxpuRsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNPPiXpqWFeQS33nRLUnHsBKngretaFgx7K0M/DVv+0JfN7Qx5R8NfKhSMqZDLoFirHdWLLoa0EpogMIOmpBkzyJD5dMC+xjVdpK3XTUfhuDVqCtegY7xpy73BrTdc+83Lf7LNaHRE/TYstdNT1E5kW1U3stnEV+9HOkkMAk8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABS1b5gB; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABS1b5gB"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be06c02f66so78400eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127799; x=1773732599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K/YC43JaMjg/lgU+h9WNDYLR6OqHnqHgs5VzidUdCY=;
        b=ABS1b5gBkufIbCd+Y3k/PdnZYG1ndnEGiHrSFMjIyGgsGGK5Oy6B7MRwWU7hoNzSgX
         xt3RCW3mB2UOnvmaE4jA5u7V8HwdmxaKb8Iq/U8aGRxAKHaK68kBENu0HgpdwY+sywUz
         Xv1SFAuEJ7IYMrdoQwkFWyx4PmgYPtWSYZSfH0BsDP9VT69v8LuNoiawKg+hkSuCKxak
         bMYh8ZE8U9VkCN8FHOog3KSNn4HCyjj4gxPpqMLsDbpQCGpOFNTvohfnbZj19Ed2xrak
         q9riO+SN/D/YjZCpXkTSE//5JTd1+DapFYVrM/D6K0w0fctN3LX2MFiSjdSXm+oj98zm
         vr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127799; x=1773732599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2K/YC43JaMjg/lgU+h9WNDYLR6OqHnqHgs5VzidUdCY=;
        b=BlgpYNJ1LO1K9a7jjE/9/KlWnxBT6SYblZNC7NMwKS48lhgs604hBaP87NLBH7GcEi
         aSyJ5YCUB7bntZcfn0TqKr/KqBK/TllD3vvp0GQjEBR0t/QK8cHIrrvJwo28vME/Guz1
         KDi33ycPR3F5RCwvr0+/UiLF1BaIOWLXuwgxfNmcsDKfXUWVrjA8rXgCl0nvyovvPSTT
         zh7I7Xd7SEchmMYJO0yyBgBT1ipwL7vCSURfZrv5W5gLYmJKgq0YVJYgo84DIAYlwG8g
         n88os4X9SBdpYddW35/t5afTnQ01H3fY41sAFeGm1meZ0OgaKm6e9iixVdBO20CqSiMC
         9E2w==
X-Forwarded-Encrypted: i=1; AJvYcCUbz86fOdjjjevoFIcTJKtjZpRm86xJgM59EnezwuBs95H8u61ciPuGxaV8G01BLshtm5VUDXdV3lhMkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyITmiqZP/jkPXC0/vYP8xh3h7SJr/eQic0FK0+agw9c9Y8hhWI
	K697Zq+3VOvUdwuWTaPZZzf0oilW+Big/xxivzZsnXQ348brZKmt/yp/
X-Gm-Gg: ATEYQzwZooYM34w7JJyK8kAXftjXMw5pZU8q/mP5GV55iHSzz2BPvAmnrgX7DGiWPn7
	CfKi2g7Wn0ZSnHA6OmaepP//FievxELR1paFtz/HWCXb0Heyx7Kn8XRIJhv/E6sI3zQfbfL146m
	W7fKPeOOYeGRa+LjKJ4w771XjOcGzbyoKYNhfDFWgse9NSi5BZhoQNnusZDEHpLkLG+Ks/7XZH5
	OYkyKe527tBIP9pxoMMDCaoqJoxnUFSkeVABDwOKz97MDv54M4ei5oTIyHp6umiV08/l+QFQVND
	PPtAvHrfYwHWUQnHq6nA0h4ruxCJRBHXQLOgMa+3WT/1WWg2Z8EqsaIkZSAHSiEhYgkrK62drhE
	HIQslQmaL/JmFb2lFDl5AQrQgQsC/Zej1kkaFPVsBAG9pV0lec7RPG3Yltzz/e8UkNfk17GJjaM
	IC2PH6+VY9H+xP5dhk7PqdIcmDTmbNLJrpQWzKPPI6QMVJZ76ek8euXvcjcUTZL8FMUroDiBwzu
	Pcz8+3NQ1yQQVA=
X-Received: by 2002:a05:7300:a10c:b0:2be:b50:68fa with SMTP id 5a478bee46e88-2be4deb932bmr6181300eec.8.1773127798813;
        Tue, 10 Mar 2026 00:29:58 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:58 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH v6 19/19] HID: hid-lenovo-go-s: Fix spelling mistake "configuratiion" -> "configuration"
Date: Tue, 10 Mar 2026 07:29:37 +0000
Message-ID: <20260310072937.3295875-20-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in a dev_err_probe message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 8ffa25b20f9c..01c7bdd4fbe0 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1396,7 +1396,7 @@ static int hid_gos_cfg_probe(struct hid_device *hdev,
 	ret = devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_group);
 	if (ret) {
 		dev_err_probe(&hdev->dev, ret,
-			      "Failed to create RGB configuratiion attributes\n");
+			      "Failed to create RGB configuration attributes\n");
 		return ret;
 	}
 
-- 
2.53.0

