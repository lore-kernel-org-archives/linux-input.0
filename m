Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795203910;
	b=kJ2CDPmFzyxDpC+cEkTqApJDkmxvTUdrNMoORXj+L6GB1U41I5voiboScp+nFbdJE+3b
	 yOcrb+maLOt3Jb2xkxM5qnpJhDsMh33fGfbrXaqYEZtjxaX5ceCJfJa3vEv6C7zgJ02Mb
	 qEq8KkFWTVP/bVWTIlRi9od5VYP1ltAblS69tlgSODKfjIHmW4zdnC9ifKkQTliZVhcIC
	 In2kMgqvlVnQklb+6OzKaS8pxvkJ/6ooxZspv5/Ai9E4oPJcWfbx6bjUU6+d8WjZ3I/s/
	 4FBpTsIVw4SYI4Fd88CbZ//IAdfgF7QODt71gd/F9VsJ+63rUF1K6NZk47JkS3V8biQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203910;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Wr9zFEBn2Yml3t1O23TLCfk4wIZeWQhiBnnGr65cndY=;
	b=SHVfntwwqDH6l0BIbWAD3dNiMzuTEzrJiRAx0gfu+/5Z1NFQevzOxBvx4WvNuMSxIOgR
	 6lO2n7RgLhRrimjK/jWqB6RfyTnNlj3Ftyr0kGnwqKcK0EWLox5q0M+fOpodtxFTbBrUB
	 7SUpXVC0n/dD+VA1UyDznScw3t1Z1j8k+W2SZ0nsjbxfMQrn1k+66+21lsrqntdiV0euZ
	 oIplr5ZFGxGkMk4Rv+u/hoJDIbELJZLV/nDr40hmZaCNmmXmZDj32ujr2HmOi8DGRkOqI
	 6keAFD3klC/1H0E6GLZeGII2VaTgu6YL1V2UE4QGP+lZun5AjVCKf8q0ON1mpdUonZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YExeQHFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84A606A6C9;
	Fri, 20 Nov 2026 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YExeQHFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A41F000C6;
	Fri, 20 Nov 2026 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795203909;
	bh=Wr9zFEBn2Yml3t1O23TLCfk4wIZeWQhiBnnGr65cndY=;
	h=From:To:Cc:Subject:Date;
	b=YExeQHFJiSHA6UcrdNEFs2p8aZMoTwLwB7O3B4zEkhJ9f0yvm8F3PrX5C8MFFMZLv
	 8jG5CtXIFWqnXOmwat8yCTasuQ4fieaEl0jDhqmwtq/r0t10wFTuNtkby3hysgLQAf
	 GP6LxYXpfvo2TotPdGj8/5jpjKE3JYqc1dGuBg2Vq8fkuvGAd3hiR3JP1NFmN6k3fc
	 HjUB6bSMooHyRgBW2B8xGejc7/LmEdR/z9X5HHHg+aDAln4J4QZYp9Xqg1tbefWgwZ
	 CX0DAkALuAZL5TeAeJirSP65GLoAjiTukA18aPinbqBWEY9GoQH6nWxXkUDh3OPWi0
	 2u21yjn047yyA==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: semantic conflict between the hid and pm trees
Date: Fri, 20 Nov 2026 14:45:07 -0500
Message-ID: <20261120194507.593601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Hi Mark,

Once you take the current hid tree again, it has a conflict with the pm
tree that doesn't break the build.

d220bf485598 ("HID: asus: Cycle the platform profile from the Zenbook
Duo profile key") in the hid tree checks
IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE), and 699041135f75 ("platform
profile: Extract the core from ACPI") in the pm tree renames that symbol
to PLATFORM_PROFILE. With both, the check is always false and the
profile key does nothing.

It's the same rename you already fix up in drivers/platform/asus/Kconfig
in the pdx86 merge. The fix for the merge:

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -438,7 +438,7 @@ static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
 	struct asus_worker *worker = drvdata->worker;
 	struct asus_work_action *action, *pending;
 
-	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
+	if (!IS_REACHABLE(CONFIG_PLATFORM_PROFILE))
 		return 0;
 
 	guard(spinlock_irqsave)(&worker->lock);
@@ -870,7 +870,7 @@ static void asus_work(struct work_struct *work)
 		asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
 		break;
 	case PLATFORM_PROFILE_CYCLE:
-		if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
+		if (!IS_REACHABLE(CONFIG_PLATFORM_PROFILE))
 			break;
 		ret = platform_profile_cycle();
 		if (ret)

-- 
Thanks,
Sasha
