Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534514;
	b=Ja1GFctDefJrulHJJEXzReU3Ze5jHYeTPVTenha72J0zYTEnejRM43sJTLaiw0CmXQjh
	 qiL/GbMMNBuUjhsRm36/KYV6ifjdohRIKikAXN/ht/bDqG83hMXUJzEHWU9eRP4fMUkk/
	 s1aSMTSnZjPb3e4ZQ+/An1i4e071Pgr/3jTKuRgEyMw7yJJPlIRj1Pl4pQfionjh8jTvC
	 xFiT4DdhiYbMkh1QObDACGzuyNOXI+HriZcrVMC2z8MlDJfeCvJGzPEC5ui4WXB4FY4oY
	 BA4OzjllCBbnGcDijt71dEFaGDrWOyJ6Y5fgyLQFLaKlosUvuCyKBOBcwr6/KV6b2cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vhmq86eX3c8OctvVjT3o+A7beFwqEkoLPX8Yx106nEg=;
	b=xhF6rMb2c22YJ7I3InflVfoZi3pgoX8+hutwCI5VXeChPJjKLXzWZfvkTorEo8mujMyX
	 CIHWuG2T/Um3cq1nBYolWu6Uvs7UCzMQaJUN4n2Olrhc7g5mzAluMNg7P8Ep6+8xRZRAq
	 0Jzl1vy35RKsbrk9HCsXmmrCsniRGjAzi8Bd565tMmFrtl2xOfT2ttOi9JYywp0mEJH5p
	 AjR2Y0+kewPyjP/tD09k+tqIGDphRsBOmo/4kD34Ut2MpeAsmQInZ74o0usReUXpjJrko
	 G2KbxvdS5c4bLZPIHd6thOWoXJJVVC+36chfKaQ2Q3h1ARCz+E39L6tkk33989FmkIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhWvM9JW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2A606A68E;
	Tue, 24 Nov 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhWvM9JW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85501F000F0;
	Tue, 24 Nov 2026 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534513;
	bh=Vhmq86eX3c8OctvVjT3o+A7beFwqEkoLPX8Yx106nEg=;
	h=From:To:Cc:Subject:Date;
	b=YhWvM9JWVNrIVndy+9xoEA4B31S4NsBTpYXEhHM/8EMHKzrgWtZgmt23qI64afdO7
	 08jZnGO6n8iwPCA/1TJLYNw6F4QDcgx3NVlFz+aMeV+lCp24FYvfTj+SrqmzC9L5i+
	 DRkIZnuJ33Wixtepgo+ag0zg68OgyoWgrgUi7e0K5pA5cqR/xaAwaQ9N6TTk2wG4sa
	 nKSTCOv3ahFTfR2Y3e1xharpAvSlBjLnc+05nm8t82v8i0QUNCAtjG7+E5+SKnDAef
	 TfF2TFB38Umqt7TQ/Q8lddN/Bi9Wby537Z8ZCqsL51tOCab5jp+v1MJkiq+NX7Z/lS
	 SSAIae0YOey9A==
From: Sasha Levin <sashal@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: asus: Check CONFIG_PLATFORM_PROFILE for the profile key
Date: Tue, 24 Nov 2026 10:35:11 -0500
Message-ID: <20261124153511.702197-1-sashal@kernel.org>
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

Commit 699041135f75 ("platform profile: Extract the core from ACPI")
renamed ACPI_PLATFORM_PROFILE to PLATFORM_PROFILE. hid-asus.c still checks
IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE), which is now always false,
so the Zenbook Duo profile key no longer cycles the platform profile.

Check the new symbol.

Link: https://lore.kernel.org/all/20261120194507.593601-1-sashal@kernel.org/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

This needs Rafael's immutable acpi-platform-profile branch in the hid
tree first:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-platform-profile

With the hid and pm trees both merged, hid-asus.o calls
platform_profile_cycle() again with this patch; without it the call is
compiled out.

 drivers/hid/hid-asus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 342a97df44c89..0b9cb5e92dcd6 100644
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
2.53.0

