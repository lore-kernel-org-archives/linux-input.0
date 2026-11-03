Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673926;
	b=Rde6UqZQnuvKjxOIQuA9Rp6hp6aNJDyzqxaSt5n0zjlxOyhDEO9Hx7CIfuuIZGm+v3VW
	 io7QggQVRUiewIVHIPgmGlOpUfo0Y5lDCQzPrVKo1RST+YTxnzcriI8420E+iMoy8VfV2
	 A7ZInaUQcpX5a/tLbWsM1VhGadjGPXutvGfywsmGB6zr4xjWC/HzinRWUeF6rcZDVxPgT
	 8FCA0PZoHVpyQpri/WZeiREFkoeMSHFi8pxvu1qoiH2r3tj5pEE1tA1czDPNLGULr5IhG
	 rGKAVL4zXHxjYxVH5Q+CHN/d8AZObik+CZDzr6jPws6mlsTljPblNNiRwbr6kVLfodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673926;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=I6x8Uoo6WgKcgwkI5Fp/tPeI1X22/m/hO1QLUnpOEDM=;
	b=5cpJ8Eiul9D0xovexSDQGiAmt9CPlSIaVpSnZ0ZTDbHvIi4j4hYQjpu1JtTOQ9Zgh7iU
	 inl094WbFjjic7j7GfiEZCLPvANWatu8hkua0SU1z0NdjbDZVfz83vA1lkjkT35L8qpvP
	 8RdDSK4BlLucQCvEFNcZBMab65Cu13BbzAPA4FW4feEiqG6fi1VlM81xQFexvLxhNaHe4
	 rBWy8f+xAa9NoMZOZNZyXRDiCQMWR7YDUoXbusRn/XbJTBveQRKeg41JVbCZRlpUy2N6v
	 /Wl8z9qdNK8G5N6+yKc+aQVIFfazc9KxzCqxFYbuEqWSiL3RSd8DQkBAF5/N3Vh23NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=QDHoMTLq;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31960606A333;
	Tue,  3 Nov 2026 02:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31960606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=QDHoMTLq
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a35;
	Tue, 3 Nov 2026 10:45:20 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
Subject: [PATCH v2 0/2] HID: bpf: fix device destruction races
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19f4bfe8303a2kunm153cdd6b10a848
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGE5DVkMfTExMTxkdSBgZTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0hKTE1DVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=QDHoMTLqadw4tZhxGorBOXCznuv+VnTmnCKFO7ZSX6IoeM0b6NIBzio2sqthz/d80wKMyqvKn4PAO12ZhMl81hZgF7DHWA4L0UXpNVLd7nF6CwlHliZG39zpXbSFkRH13OhGrryq2yC1NPme205bjSZERV3uLQCTwfXv0dMyaaU=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=I6x8Uoo6WgKcgwkI5Fp/tPeI1X22/m/hO1QLUnpOEDM=;
	h=date:mime-version:subject:message-id:from;

These patches fix two HID-BPF races with device destruction.  The first
keeps report metadata and transport-private state alive across hardware
operations.  The second prevents struct_ops registration from publishing
an entry after destruction has started.

Changes in v2:
- use a short lifetime admission lock and SRCU instead of holding
  prog_list_lock across low-level driver calls
- acquire lifetime protection before looking up the HID report
- clear ops->hdev on registration errors before dropping the device ref

Yifan Zhang (2):
  HID: bpf: synchronize hardware operations with device destruction
  HID: bpf: reject struct_ops registration during device destruction

 drivers/hid/bpf/hid_bpf_dispatch.c   | 73 ++++++++++++++++++++--------
 drivers/hid/bpf/hid_bpf_struct_ops.c | 12 ++++-
 include/linux/hid_bpf.h              |  1 +
 3 files changed, 65 insertions(+), 21 deletions(-)

-- 
2.39.5 (Apple Git-154)
