Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EB3EFFB8
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212305; cv=none; b=QrakKmHSdengRg435G1O6SkStM0k77X0vPw4H2dOgJX7raIp5TY29DkJLXQ8SBn+0Wf2x1111q/srTj1sMFD2HH3ZRqCSKsh6JpwnstGairHLBefbo0uba4eWUJPOSO4bAz6nLYJGI3YggraxU+G1oyFvFKBsC5zrbGuv1JFEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212305; c=relaxed/simple;
	bh=rPnAOq3nZd3GjEczjc6mC2QeoMzYd4uHWdju0AepcZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI9whuF7FRpqocZGRzDZibX0FMB1UnEDtZU20MsvZf0CBGVRDWFOn2K7teib4s4SnvzF9AKuqjhUX/QprPWgrYek+KktmcrSNimqIRrlQJc8e2VZcJ9dHqnHnbN971Gb/beVFP2ZVjf8OVVUSBiyrTUbN571zEloUb+E1dyGdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=provdh.com; spf=pass smtp.mailfrom=provdh.com; dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b=ZfVN5g01; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=provdh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=provdh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=provdh.com header.i=@provdh.com header.b="ZfVN5g01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provdh.com;
	s=protonmail; t=1779212284; x=1779471484;
	bh=wW8ynPgmcD4glszt2JHg3RttAcx+CkDVnRzXTH23oUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZfVN5g013R+OxrjTk/N//7XPT0HMAN8x6g0W1DC+1fH0tASo3oZFarY21bS+JQTo/
	 mfgjWZ3n6U7JCXRV1Wb2vInCQ5EYzgP1trjc1dr8kfEe2DrXjp2onbUWJglLF/ZfL6
	 amentx0ssiw2U/zl/XZTKGgL3Gv55th79x/Ebi2QVvBXe2ismZI7JK3tsxWk+YFaNo
	 Xwwtn1swACBYn//jLsT4SlqBvPQElHqKbN7dBofJ/EWep0TjYbqRzcX7DJgMKLNOd7
	 41zOtFTVfMp91/PWvhqdGT1fihj/Ck35bcITrk6mJ6BbodWWsvwKbadghHU6OQqTi+
	 If+hhuZS2ascA==
X-Pm-Submission-Id: 4gKhhn4NFlz1DDXC
From: Justin Opini <opinijm@provdh.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Mismatched product ids for the ASUS ROG RAIKIRI PRO
Date: Tue, 19 May 2026 13:37:59 -0400
Message-ID: <20260519173800.6765-1-opinijm@provdh.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <Zjb8RrOFLHFSk_Gv@google.com>
References: <Zjb8RrOFLHFSk_Gv@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Dimity,

I had a question on the product id,
{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },

This doesn’t match both my devices so I was wondering if somehow we have similar named devices with need for different product ids or if there was a mistake in the original commit?

My relevant entries from lsusb are 
Bus 001 Device 002: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO
Bus 001 Device 003: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO

On my system I have ended up using this udev rule for quite some time
ACTION=="add", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1a3c", GROUP="input", MODE="0660", TAG+="uaccess", TAG+="seat", RUN+="/bin/sh -c 'echo 0b05 1a3c > /sys/bus/usb/drivers/xpad/new_id'"

Regards,
Justin
