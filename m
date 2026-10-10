Received: from e234-57.smtp-out.ap-northeast-1.amazonses.com (e234-57.smtp-out.ap-northeast-1.amazonses.com [23.251.234.57])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B74582EF;
	Sat, 10 Oct 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651474; cv=none; b=s9yVS9vfC+2i37Xq6sPes9ExR7zrBgZ/gGo+wQhktA54IZrvv/BYiayXcpLjzd2reSK6tzwT+eKCByu4phgFqi5oA/impYdnPTweR8htW4TFQOzyKzYXAkY+ZH2DaZLRLIN45/+TaYPNUd8YQGzXagVjweI+fGJWiTNFMQMSn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651474; c=relaxed/simple;
	bh=R101s1JAm81QfOw00PtFuU3yhRQhQAZva33Ah/p0Lbg=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=Ey6wU8ezPKA6HjdvJPQF3mgWjsWcFBl77LBZ8mCr1CDxyugzLc1lT3kJWPtmPFfZBndeuhDXOODu8ElLktVKj+XJwcGrLG2s2J2gGT+OY0fXsBP8pgf94ewUYgclJdFbeHltn5+POF6rUUuzM6igzg9oBAu9jQu5hzgeyFuGFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=ruxRkX/J; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RRBx8yzg; arc=none smtp.client-ip=23.251.234.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="ruxRkX/J";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RRBx8yzg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651471;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=R101s1JAm81QfOw00PtFuU3yhRQhQAZva33Ah/p0Lbg=;
	b=ruxRkX/JiSyDV/SuBKfG4ouwheV5UFzjDZu5ycGQg5IxrW5YeDEBPGONF2QTQDVn
	q/uDdqwcc29h1xBnjSEsrEYVt623ZSd0BvpvsB8zS8WWs6H31IIf0/Yk6T/snbxG5f2
	Hwg5Qb9wJ7hdDGZTigoW5lZxq16NMWsBPL0CDnrc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651471;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=R101s1JAm81QfOw00PtFuU3yhRQhQAZva33Ah/p0Lbg=;
	b=RRBx8yzgP8QsRQP5rwsLiYYrRhlM4pA88X8hZakqJpqNGrl1tP6+rdZvJQr8KkAy
	t0WSnurEq4G183AXg7Ahxc5EHBfkHmQlt1qZOYYmluA8nZ/L9YzXnBh5dirlT1hBpjN
	9iXXSkEHETv8i45AbYuJ57XUuWwnfaYbuz6cCgRo=
In-Reply-To: <20261010165732.43465-1-fqwqf@fqwqf.xyz>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: [RFC PATCH 6/6] HID: spi-hid: expose readiness for reset
 diagnostics
Message-ID: <010601a126bfe036-2b296fdb-9206-47f7-9089-99c1d09b240e-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:51 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.57

Retain the read-only readiness status used to correlate descriptor
refresh and hidraw reconnection with iptsd logs. Document it alongside
the existing bus, regulator and device-reset counters.

Limit the Romulus maintenance entry to its binding and ABI documentation.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 ...=
/ABI/testing/sysfs-bus-spi-devices-spi-hid | 30 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 drivers/hid/spi-hid/spi-hid-core.c            | 11 +++++++
 3 files changed, 48 insertions(+)
 create mode 100644 =
Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid =
b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid
new file mode 100644
index 0000000000000000000000000000000000000000..=
5c55748a082e028a2fb7a0aadbde5d92eed50950
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid
@@ -0,0 +1,30 @@
+What:		/sys/bus/spi/devices/.../ready
+Date:		October 2026
+Contact:	Jizhou Tong <fqwqf@fqwqf.xyz>
+Description:
+		Read-only generic HID SPI readiness: "ready" or "not ready".
+		The device must be ready and opened before input is delivered.
+
+What:		/sys/bus/spi/devices/.../bus_error_count
+Date:		October 2026
+Contact:	Jizhou Tong <fqwqf@fqwqf.xyz>
+Description:
+		Read-only pair "COUNT (ERROR)". COUNT accumulates transport
+		failures and invalid input headers since bind and may wrap.
+		ERROR is the last such negative errno. The two fields are
+		sampled independently. Unlike the previous downstream SL7
+		driver, a successful transfer does not clear this counter.
+
+What:		/sys/bus/spi/devices/.../regulator_error_count
+Date:		October 2026
+Contact:	Jizhou Tong <fqwqf@fqwqf.xyz>
+Description:
+		Read-only pair "COUNT (ERROR)" of accumulated regulator
+		failures and the last errno. Fields are sampled independently.
+
+What:		/sys/bus/spi/devices/.../device_initiated_reset_count
+Date:		October 2026
+Contact:	Jizhou Tong <fqwqf@fqwqf.xyz>
+Description:
+		Read-only unsigned count of reset responses processed while
+		the generic HID ready flag was set. Starts at zero on bind.
diff --git a/MAINTAINERS b/MAINTAINERS
index c52ec2d7d3c12ace1f6e2f6012a328=
44bd8f364e..858ec47345400b0cf751e7c8cc13140b462c701a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11626,6 +11626,13 @@ L:	=
linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-nvidia-shiel=
d.c
=20
+HID OVER SPI ROMULUS13 INTEGRATION
+M:	Jizhou Tong <fqwqf@fqwqf.=
xyz>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid
+F:	Documentation/devicetree/bindings/input/microsoft,romulus13-touchpad.=
yaml
+
 HID PHOENIX RC FLIGHT CONTROLLER
 M:	Marcus Folkesson <marcus.=
folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index bd27bc3ea34c5fa65a903dd204800dbdafe3a7bc..=
167ee347588fd6248c647e8d970324e96d99d8a8 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core=
.c
@@ -1568,6 +1568,16 @@ static struct hid_ll_driver spi_hid_ll_driver =3D=
 {
 	.raw_request =3D spi_hid_ll_raw_request,
 };
=20
+static ssize_t ready_show(struct device *dev,
+			  struct =
device_attribute *attr, char *buf)
+{
+	struct spi_hid *shid =3D =
spi_mem_get_drvdata(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, =
"%s\n", test_bit(SPI_HID_READY, &shid->flags) ?
+			  "ready" : "not =
ready");
+}
+static DEVICE_ATTR_RO(ready);
+
 static ssize_t =
bus_error_count_show(struct device *dev,
 				    struct device_attribute =
*attr, char *buf)
 {
@@ -1601,6 +1611,7 @@ static ssize_t =
device_initiated_reset_count_show(struct device *dev,
 static DEVICE_ATTR_RO(device_initiated_reset_count);
=20
 static struct attribute *spi_hid_attrs[] =3D {
+	&dev_attr_ready.attr,
 	&dev_attr_bus_error_count.attr,
 	&dev_attr_regulator_error_count.attr,
 	&dev_attr_device_initiated_reset_count.attr,
