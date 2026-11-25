Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633670;
	b=bzKmE39q1qUCr688GSGzd4WxpTpKgwEmRrPhbW8gszgRjx5CeuCEoZ4Ao3BiXMKo7f7N
	 Bco5v9ueYpMW2lsYy0ANzXQQNHaUmEfZIPxmEs1rfFXhVTlGb9q9+y7gAjQ2lTVfgpoP2
	 AgAaDN20vmsuS/oTrJ4bVgEhDigiwTODrPHpPCKGcS2OU7Qk9LDW0N0iuBNCXUpU+NHkL
	 9HmkVylkefCmko1HDmSudV3cORj9mMqZdr0J+N13D1Dlt+Li3QiS1lwh9yIEMvchicMr3
	 Zo1DdNFPGIZRK6aeacap9KAiLD5S8V8v0Ho1ueIQmmK4mEkHKmcroxiu/pCbQBlL1eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6ZkxxOMDqkeVS9tns9euuwURcFwSWkP/LQaqu5Nm+FY=;
	b=LpWQJx/dTKxOdY3u98924VaAk4v9t+T+xk0CGxLSpYVOKQ3vFqGnDv1Kk/zbhN4ZhAW1
	 RVsQluS1iRdoW57qC2d3KC2WBDYgbKb1SXoHjohrWuFQO47Q/huosv+PiUwG8638Qim01
	 KikJ/5xg7M+uO8X5KpJ0eQ+3hDA3M0cqFLTjfzsVK2bKplPY/qGMSWyTgvirEMIBizmvI
	 ZQsKgQmP3YfHP2GktczR7Fgd+i/29DU28upCVu0o6PILJ1kSATc9J3MlTw4CwH1ockhN6
	 12QROUlCcyWpM5FaeveOQMZp7lNzWaUCPMeJ9mwnSwasE/pSQOG+M2dxmOuIonC02CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x5RI60/M";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606A606A32C
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C606A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x5RI60/M
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-18818daa3e7so3594074c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633669; x=1796238469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZkxxOMDqkeVS9tns9euuwURcFwSWkP/LQaqu5Nm+FY=;
        b=x5RI60/MzFExmOQJVqzH9dvtf9/5lpQ5aEuFTCyldPxwdRHMWReCZiM66m5mQevnOC
         24p9Ye7iBrEJ8KQK39KIzPq5dIHWgKtvq2ZnBi8cPgFm04uy38keKwpG5GvuzQ3bwyAJ
         6acVwshjCzHd4fvWMq1+0yts0TF4McBIGvmIpTZm1qKhUXf2AlOl83pNfwD4UonhQDzt
         qWqa49LV0UMkbStyt8cWxbbQkJvFqHvOd0x8gU43WRPJgfoSiqpcaDHeUO/Jt1Q1yCSx
         GDUaRHjSy5wfPzmETe/Ogh6STqW4g/OgRfIW7EXwK5iLBFw7Z56qh0wnalg7RdHrbaU2
         YTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633669; x=1796238469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZkxxOMDqkeVS9tns9euuwURcFwSWkP/LQaqu5Nm+FY=;
        b=ZTULOa3tMT0iNat9e+whImIyFTYybeGcAzd5MiawYZkwR9vzXdfCjm0M/5pwAr4bk9
         X33W0AzTlMgtwa92oWeXrRuWAWtxxjYKueWvL5x7uLskpT3RLmhGOvowFI89HmPQZVgm
         OBbD8Cc5FmtjCQ1+tjIC3jlDJ2OvG/eWPJcRZ111EJRc3dwJPJepcvfTixnBRoLu0xnB
         HXW0r/iB5RbI356bSJl1RYs8LQAL0If6byyvjmOKxja8bLGigYWiRjzyGwpT5FnMyRtY
         7BEKauYQUWlrkjjsxKlvEi8r/RCz9Uk/hF38MTgR8Dwqw1ai+O3/G4tSQSTEFES4Hk4C
         2tsA==
X-Forwarded-Encrypted: i=1; AL+hErG963LbyMpt2vtD31yN4Ymdz1omtOl0pY3B0oATi2pgEhoRE51fbb6hD6oruZx2WBcetJF2fq1hdmSghA==@vger.kernel.org
X-Gm-Message-State: APuU4Z94NTuaIIJIYsgIVt599fXgwXx3fA6Kuv4Dlt5Ip1idE73edZWL
	uq0WZpH4A7Jij2jIxXWh5NlTOCxUoEUkDsVP4QA8Zx2u1NvJf1evjJmG
X-Gm-Gg: AZFdTZf3MECojt5rgv2/tCCz89MH7xVMbQNM0kVJlDgTsbzzmTVH9nQakaz2l4j41wk
	IcCCcB98NW+7CZUNHYo85rIGuDGGysCCbPH3k+Jyofq5pz6RHsgSQbrOyLSHhR91xJomcLsFfbk
	aT9jVCLm9xtTyiyxRM5C4KrOhpmszx1R9gQCWJdCaP2eO7jHRzU1p1fzaDHEq2e6Pg6IWQgB/6i
	HYJN/DsSBfdbmSzM2e+Wlquk/lYRQSpx4ggVgtMemSOYejpCCJFF7I8bpCSyvsrX57DTA/XiH4L
	Q14b8pt+I5RwZJ/+O+P60MzNSvWjY0EZOFXodiHMEMLZV+kUWWHnzoap7kUlHGoIdFex3dcRZcj
	GoaQSEYIvHVg6DT24IEtAxfIRlO4YUbupr0KU2543bWQGpahe3yvKtlnRCPWKZLyRWktcCic9Hv
	hm0hModxNW1BdQq7AaphjHn1Xehn7iJISM5WJCCYHKznox/U65VdLvaGxZocCveVtd1a6w6lKsr
	39VQ/QK1hiX71nnApUZlj3BbazDLcgX6vKYpxt55wHFQ9uR3jHCWFvWYeXKJNUPVrBkM7lonTFx
	bcuoz4YhI1hDi2G0sJPX
X-Received: by 2002:a05:701b:4213:10b0:185:6c8c:d860 with SMTP id a92af1059eb24-1b5568aac8emr18988658c88.5.1795633668803;
        Wed, 25 Nov 2026 11:07:48 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm42584510c88.2.2026.11.25.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:07:48 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 2/3] docs: ABI: hid-lenovo-go: Point one entry at the version group
Date: Wed, 25 Nov 2026 19:07:41 +0000
Message-ID: <20261125190742.2420486-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125190742.2420486-1-takano32@gmail.com>
References: <20261125190742.2420486-1-takano32@gmail.com>
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

The protocol version of the internal MCU is exposed through the
"version" attribute group, but two entries claim
right_handle/protocol_version: the one that describes the internal MCU
and the one that describes the right removable controller.

The "version" group has no entry at all.  Point the internal MCU entry
at version/protocol_version, which matches the description it already
carries and the group hid-lenovo-go.c puts it in:

  LEGO_DEVICE_ATTR_RO(version_protocol_mcu, "protocol_version",
                      USB_MCU, version);

Verification: get_abi.py --dir Documentation/ABI validate no longer
reports right_handle/protocol_version twice.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..ed8d9a35b8ca 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -386,7 +386,7 @@ Description:	This displays the product version of the internal MCU.
 
 		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
 
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/protocol_version
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/version/protocol_version
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
 Description:	This displays the protocol version of the internal MCU.
-- 
2.53.0

