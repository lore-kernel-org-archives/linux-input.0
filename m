Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF2389460;
	Sun, 13 Sep 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341013; cv=none; b=fxPhxU5LX/q3q4FWvwCyZFUsvao/vw7dYiHO9o9zQWTWZB1I6oVdyK1wo+vAbmlYIw5xgDG8FSQuIiV2TAEgrUJUAhvJiG6cRpomBD8NldxfftBAKv0iRZKmrl0K09coQ4ebnQwoie40yVzjldGtmlPDnPMFllNN0Th6LvyLV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341013; c=relaxed/simple;
	bh=JovhkEGc49m08i3QruZE95i136J5ceZGjBAIjri5/As=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmoDdx+VDLunTvCWl7cKAPgml9j8deIIz5g64wuJX/xE2u3q8LCJTUJmzoUk0/sm5MrJEZ1mXDOD4JIgQYWIyb6rQ3zSt2lqnzcY5uD1SAqjUaPJpElhQV+DpTfH66MmPndc5XGdCnmB1KnKL7uc4Qls6sJXCdLx4ten47eC9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SI396ToJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SI396ToJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pGJNvAGV4/Il1YF4g+q03KS8GPSVHq/XLbwQYYi2pFM=; b=SI396ToJ28joaN9NR5srWPPjse
	zKA9hiof31o8RtEJ9SPquhUawksFX0XVN4aAsvHfelwHdqZBJoWc+1ZcRgT1n0GSy63qCNFvZyOHO
	UATFNZoWSKa75mp4OfD4vC9LQWw83FmdS4bwg54qs15eB1AHHCDk5mlIfAXbdiOCNDPk/9hGW5RLe
	UMQ6Ouckw7/0Xljt+RmXplN4/WrxSqiF+DKToHMA5LfCwbMzOlpm+i2KdEMd8Xg0j2aY6NgvcCa66
	F9dgPFBEPgacOIESPPu1ZwIqiUR8A3jHDvGschYqUxNHdWXnP1DRaKiZrgE05+Fks0XQreHPwbYfR
	wfBJi94Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5tKo-000000025jN-02j0;
	Sun, 13 Sep 2026 23:10:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: correct typos in hid-lenovo-go-s ABI doc.
Date: Sun, 13 Sep 2026 16:10:04 -0700
Message-ID: <20260913231004.1007869-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spellos/typos as reported by codespell:

sysfs-driver-hid-lenovo-go-s:185: intertial ==> inertial
sysfs-driver-hid-lenovo-go-s:185: measurment ==> measurement

Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Derek J. Clark <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jkosina@suse.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org

 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260911.orig/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
+++ linux-next-20260911/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
@@ -182,7 +182,7 @@ Description:	This displays the available
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/manufacturer
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
-Description:	This displays the manufacturer of the intertial measurment unit.
+Description:	This displays the manufacturer of the inertial measurement unit.
 
 		Values are Bosch or ST.
 
