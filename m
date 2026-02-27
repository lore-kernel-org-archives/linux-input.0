Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5C28504D;
	Fri, 27 Feb 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186991; cv=none; b=P2QalZglzy5GI9NQKWWiSJwQOm5S/un+COOb6aZrF/fivmQuhVOgG0YYxOFy7LbOaXil1xhMJ0qjNFu3HobA15tdiqF5/JbPp/p928xFbvaS8EX3KOCFWUGm2l4FzzHb8/D5Q8rlB1gWf8DdEaRVSh0+vCDmVmO+zPnTGOq3KpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186991; c=relaxed/simple;
	bh=xWY/I6PTnrt0NOM0bobMI54rBxerOxOO95XDCeHrkEg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aBwU3R7gvLpYPnQAe/0Yt5m9gqidNIrhfTUJQY2XkROmKGqiu0gOFyrRHV0xYBNYWL20FRZdNls81PXRrK9dKe/y8pdW2pTJsgsSSJrYGCBYCDYDbAy0FzZ7dkBj/36EK7evRfxaOr76kPt0yEGTNyy+LxftPidmCJM3Pr3us+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPhthyXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPhthyXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4DC116C6;
	Fri, 27 Feb 2026 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772186991;
	bh=xWY/I6PTnrt0NOM0bobMI54rBxerOxOO95XDCeHrkEg=;
	h=From:To:Subject:Date:From;
	b=iPhthyXf09scn1AXzLVemxYbqs8HiXw2DDTgmwzXa3zvv6ApGPYyQm90yE25QyJs8
	 qfgbTrYNKT3bKPP5xXliSQJ6yE11IQaMmuQIUEq3NkMjrbF0uwZYC1s79lLqGdRh3q
	 39m5Y7pJADgHOixB6n5usesuUZV+aG6PsaVOZCvcitmUyOeAtOjP/YZkqXZgrXr3/n
	 SFyvEKMYVT4f93n61ItEdbwM9qFbvtsj0w+sPv+MKAIkc/jQnOABGKYx7tSMk3I13h
	 jzSQyOqUuEU4LwlN8sh/23jz6Nhzag8wmOpwxX7fNd9s9527wDwUUTXowe3tLt2bLL
	 bK8QjSCcEDBQg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: logitech-hidpp: Prevent use-after-free on force feedback initialisation failure
Date: Fri, 27 Feb 2026 10:09:38 +0000
Message-ID: <20260227100939.961011-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Presently, if the force feedback initialisation fails when probing the
Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
will be returned and propagated before the userspace infrastructure
(sysfs and /dev/input) has been torn down.  If userspace ignores the
errors and continues to use its references to these dangling entities, a
UAF will promptly follow.

We have 2 options; continue to return the error, but ensure that all of
the infrastructure is torn down accordingly or continue to treat this
condition as a warning by emitting the message but returning success.
It is thought that the original author's intention was to emit the
warning but keep the device functional, less the force feedback feature,
so let's go with that.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e871f1729d4b..eee9ab6a2fc4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4487,10 +4487,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 
-		if (ret)
+		if (ret) {
 			hid_warn(hidpp->hid_dev,
 		     "Unable to initialize force feedback support, errno %d\n",
 				 ret);
+			ret = 0;
+		}
 	}
 
 	/*
-- 
2.53.0.473.g4a7958ca14-goog

