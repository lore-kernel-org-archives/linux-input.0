Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F036404D
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122006; cv=none; b=QhFjzA9oCU3bkEi2dp6Lm8jOqXaHwT3UcGciVgmzN5MursiBHukrE56KN8UoxubuIlTm58JE2FxjYr1lNJJFd9RJK0vhhRk9QrwSaHf1TYMVrXCeGU2FDrEv3IUzje6+UmfNLJku0tI2xTUE1xM/s9ponbjUeJAJ92bcN5F39+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122006; c=relaxed/simple;
	bh=+wDgv0WvhA8rgJNbuza+OCwHjKsQDVEc8d2Og8JU/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdGnf6tPXeFATA0t/NhAHKz6Bmhy12UMsRllgs3tws3mpjn/D0C7xNLNvdPnRJ6NQv6BAI+ngXcR/i8716oOKGBJ9sQu1hRHSQV8gmxfMPeZA32Zrpeg9yuiFTtlnHzzu4uBfeQT1KRTH9Ft9GJO8jyvUZfgVs1nR+svvSg1ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCJ2JTUw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCJ2JTUw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88e3e82d81so1820484a12.2
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782122003; x=1782726803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmkrGOoAYA8yIglYdYiYLl3mozpjURTo9qxUBIM0dOY=;
        b=LCJ2JTUwczNr344/ahbMphFequxmVKyPC9Y21E4aDhO7+ObtDVQ/aLc1w+NFKe3YIO
         +fG20cM5BfHX9illMMa4EKKOBFHN6ct6uWNaacVKCD3GFtTvOgxy9nfC5h/IMOba7UnO
         NiXec02e65wS9ssRKe69bZtTsz/ouFNcojxmXMaPb52jL26OgSmXGN2KoH+Gc06iCrPf
         pM4YTS0KsP869WRiadcbKU6zheLRntj0zEBFNx5jDOO9VySwrjZitXJ80GFZT4Fsbsp9
         gqbevRk00Gn1zOvzkswTw/D/NR8Xzp4fCaY4IrK5AYig4B/kmCwl6tslnij/+0syb6so
         DYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122003; x=1782726803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmkrGOoAYA8yIglYdYiYLl3mozpjURTo9qxUBIM0dOY=;
        b=eLBwAWopbmBTWEgs6jvtBAVQ5y96MA3ON5zhlFK8e7xO2aoy6CEPKMg6fg5QrNPbEf
         1ILUXI1sSJseKr5Wr44u5yMPfMPxqJNYFx5I8Oxd/19pj13NnS6w879cgIyOuzNWHHsc
         AQJU+rmWjt2TPxG1HiJn9DY/USv0Ab1sbwHAfeSjy3adpa2JjzZ+lUheIx9ClmmirTcK
         atvkEKHfxVdfZMBAI7tnS1GUrCIyFvj80CFwT3KB1lVFUmWtVwHyprjLgYlCnzFI8l3A
         DRdD0ywQKd8/+u9xX0fDrP2lHuQZp47f97rKXObX8FDPvPnvvne+AivUdUxWM1SWz/gP
         NawA==
X-Forwarded-Encrypted: i=1; AFNElJ+oqxOaHse1IoMIsH3I8BP4TmmJGXsXoRmvBEdYCPHQGWUT3+SAW/vq0MyPQl8r+QY9lIm9JaBK0hyqlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22zq7EUlmlTGfTLdKySfDGvU5lapCx5KGMT1s960x371ReBKf
	KERpIIm5si+xRDypqXG7QhwSBlD/fKvvB7ZJL3Vd15TAFhU/C7EjdAPF
X-Gm-Gg: AfdE7clkwz5Cw+KgZegk5LxZtHCSIxQ7kl9M2WuSj7DMC7SFFHTo5kph4S6FeDg26Y3
	DobTFUC4YZ0w3uHGF0wt+xlAKskthYpXK/SICsALtKTkveWLC+cl4y+s3pXesXUThTsRaujtNqw
	IkN9tGsghRYiYIx/eASIaLRoAbyO8VG05IGMJrvESLK6hepViTLXqhb8qbJgs0XKCAmRUnVgow8
	7Q/T1JaJoDteS37m/ZD127sm7PkYgTIX3GbvjTlHkdV+H0ap2I7O92gs3EiWJv+4jG0thEYIIha
	2jWs1VFQmb/OnV0MH3w89dAe2ArfNQ3r/t4xSqzyEFlF6nvpmy0llib9BhvNAtmhujSTONAIl3t
	sTnGDqTyJoJqsJlX8lsWUw7SkLCgTPcnniNZSzc7YJJN409E/SRaJ5VIL/SDZ/BOBnlSnpP1Wey
	tGaSNA74FsFpQ1Mk/QotR1pV8BSWxPJYgp9SCsegu7m7SDpoTJ9tc9QPqO4VpZDIsk
X-Received: by 2002:a05:6a20:b7aa:b0:3b4:6af6:faa3 with SMTP id adf61e73a8af0-3bb3354177fmr15014466637.10.1782122003312;
        Mon, 22 Jun 2026 02:53:23 -0700 (PDT)
Received: from home-cachyos.tail3e5085.ts.net ([50.34.35.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc3172827sm6573815a12.9.2026.06.22.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:53:22 -0700 (PDT)
From: Ryan McClelland <rymcclel@gmail.com>
To: vi@endrift.com,
	dmitry.torokhov@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: s.jegen@gmail.com,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH] HID: nintendo: fix clang build of switch2_probe guard/goto
Date: Mon, 22 Jun 2026 02:47:28 -0700
Message-ID: <20260622095303.837361-1-rymcclel@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512200051.2534081-2-vi@endrift.com>
References: <20260512200051.2534081-2-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang rejects the forward `goto err_close/err_stop` in switch2_probe()
because they jump across the scope of the `guard(mutex)(&ns2->lock)`
cleanup variable ("cannot jump from this goto statement to its label").
All three early error paths run before the lock is acquired, so replace
the gotos with explicit hid_hw_close()/hid_hw_stop() cleanup and drop the
now-unused labels. No functional change; gcc accepted the original.

Signed-off-by: Ryan McClelland <rymcclel@gmail.com>
---

Hi Vicki, I've been testing your Switch 2 series on a local machine here
with JC2, GC, and Pro all over USB and hits this clang build break, Patch below
, feel free to just squash it in.

drivers/hid/hid-nintendo.c:4147:3: error: cannot jump from this goto
statement to its label
drivers/hid/hid-nintendo.c:4153:3: error: cannot jump from this goto
statement to its label

with the explanatory notes pointing at:
 note: jump bypasses initialization of variable with __attribute__((cleanup))
  guard(mutex)(&ns2->lock);


 drivers/hid/hid-nintendo.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 40f57036d810..6a286d49e5bd 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -4144,13 +4144,16 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "hw_open failed %d\n", ret);
-		goto err_stop;
+		hid_hw_stop(hdev);
+		return ret;
 	}
 
 	ns2 = switch2_get_controller(phys);
 	if (IS_ERR(ns2)) {
 		ret = PTR_ERR(ns2);
-		goto err_close;
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+		return ret;
 	}
 
 	guard(mutex)(&ns2->lock);
@@ -4194,13 +4197,6 @@ static int switch2_probe(struct hid_device *hdev, const struct hid_device_id *id
 		return switch2_init_controller(ns2);
 
 	return 0;
-
-err_close:
-	hid_hw_close(hdev);
-err_stop:
-	hid_hw_stop(hdev);
-
-	return ret;
 }
 
 static void switch2_remove(struct hid_device *hdev)
-- 
2.54.0

