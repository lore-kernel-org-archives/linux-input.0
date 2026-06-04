Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8A3812DA;
	Thu,  4 Jun 2026 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547054; cv=none; b=R+7cm83vEnQRIRi2VlZzQhU9qYVFxsl/jU+3qyI1byLbSszUUqY0JohUut97G2c1UHH05+Tvl2i9+qJ0UNHila6l/IFeCH4FQe+YUpPXn5+sYvvD19jYUW99NEmRQ1+mnGOQvph1JHfI4oDNASsBzsXwNYtv5Ck4wKvkv6zkC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547054; c=relaxed/simple;
	bh=MGcNiLfJ3XGigoWZsYw/BiAxd50STw8pUheOoNJNivc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjY5jhNw0ZPae7FawV49g/QQ37bitgzwNm+qamhoEu802VvUYmZxrm6WuzTi82Ja6HzLGqnQv50D/ov7S2D43GRUTIey/AyjyF1Ceq660N2HeassFMFJH+p2fjhSQ5tPlHf0iTbbgMbSyUk3I+zWu+LCEEN/JMzgYx2DKCx8n2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jJvaYan2; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jJvaYan2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780547043; bh=1SJnkhl3BWEkIOjvsSDm0RQ1U0inlB53zu64coRV9D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJvaYan2o+gg+4e3cRqYq40x2w/mZ7Rset37H7meHL9CSdeYn7lzO26/+Adq2L0Wp
	 v3ClMkRC39eaODht06yC+NBKCnhq9oZ5NnRh6DEJ6I6YqwCGBfBOKoprHr4MSjkVrf
	 TKOJJcg793LC0O7Lk2mCAXLsHjx7kBSGiOg+LX8A=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 5EAA82AC; Thu, 04 Jun 2026 12:23:42 +0800
X-QQ-mid: xmsmtpt1780547022tknmw0b2b
Message-ID: <tencent_F6FC553D1BB737FC00062AD0FEF43C580F0A@qq.com>
X-QQ-XMAILINFO: Md0EpfRTqfgWRBPSL8YoQXMlv+arePNSTK8kVF6ULgdZjPCmnX+fwncqOcKCL7
	 R7qnrA7Y6z/YbNbkhlpnaGl3slYgcVJNi/2Qz3ei0eDICdxdyI5mutSIWVe1BDUbwjqvlUIGQhHZ
	 vKIHyrxEAVKzgJvrVYP8MAtepwCpq/khUGLZkFoxmmLbzgdDgmPOXLDU1T38DIRfNm85Rod5XRGs
	 HET1RLCuHCnTwy9Uqey198KS6spaSmUP7MGBu8SUcSk+9EYsk9ppn6Hq0dSUSOKs+24csmxEB5jR
	 IpTGdVLV+BcGevSBThzCd8Jvsn3UTpl8Pi61xpiysAb3hf9lBPw5M+zK8if+ApEbVEjYyE9XhzjX
	 ePSJA7qGw9sSA+2joKKAxaq7CKZ32Wt9QZMSvgfyDXDVNZM0vsB4+NsSILzxfW3MnsTKEeAOu5AA
	 gsu3/mcRSLg2lsI9E8lZZiq2dt6C0FR5uZ0UdM6YtO9RBkrLG3QhA1lqZd1fpLgdlT5Q5GEA+C9j
	 cWOfoiJveb4gprNTOWIHY1Xw1CsTr4jDZj942GBkFg1Hw4s76Jt96kM2BSz0sSM8shcxnFgTkYEV
	 OIvL8MHBSyawieBXBjfIRaKoYh5FJif/Go93w0UXsrffzQjNBXdLvtYXqkyosycZvt8zzYWkO/38
	 XG+FMHqjpImcJgZdWlCB9YcDwedBA4vEO/BTPifV9zBYVKCHBsDAwng42p1GqqnhgIQm8cIDExTl
	 Ko8xtTK3/qtuGSb+ibiOWO/fV3xAUHXqsxjKoEV6pRwRPBXNnwsuHfhfyq3hDJz+M+ior9ETrvcP
	 o8g0+PsroZwUkOq0Zrt5cctZ9ttwO0LU3v/OZhDaneuitFzsBpLsFIifOgGlbq43CWHjpQUy9y8U
	 vWbnXyZOiDJ+b28MNaP/Z4ki5Dbz/7XdmbOqWvpxCWJGtg53CM8XvDNI0EFCSKZ/QESL9DyAElek
	 OY/aI39SJ0pWBJpbODRwfJ4mnt0ZxKZ2ioHhXtHZobMDqcIFCn1sHlx23ammbc/ikRDbL1HEj66w
	 TJlFXoMdkMIuVg1fWHlXCPdyRUDipWlXPVB4k1VD3azvP4jvLF7bdJ4i2JVazlIKR4JhMtQZxDzw
	 OCiYmj2/o0ua/m4U6XHmn3t4+4+D8r2Lbyz1HCzRDlfD+foMb+rNaZuppqf5xG7Dlqm5U8Qn+7hi
	 7AaCQ=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org
Cc: Yeking@red54.com,
	dianders@chromium.org,
	error27@gmail.com,
	jikos@kernel.org,
	kenkinming2002@gmail.com,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	superm1@kernel.org,
	treapking@chromium.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 2/3] HID: i2c-hid: Move common ACPI _DSM helper into core
Date: Thu,  4 Jun 2026 04:23:30 +0000
X-OQ-MSGID: <20260604042331.36012-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aiApE2WoVitHetQv@beelink>
References: <aiApE2WoVitHetQv@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hans and Benjamin,

Thank you for the constructive discussion.

A correction on the origin of this firmware quirk:

This is not a Loongson platform issue. Loongson 3A5000 and
3A6000 laptops using the EA Excelsior ODM design do not have
this problem. The affected machines — Lenovo KaiTian N60d and
Inspur CP300L3 — use a different ODM.

The ODM is likely Baolongda (Bitland), based on CQC certification
records and a design patent filing. Firmware analysis shows the
N60d is codenamed NL296A and the CP300L3 is NL296B, and there
may be NL296C as well. The ODM's NL296 project team likely
lacked ACPI experience, resulting in the broken PRP0001 +
"hid-over-i2c" + no "hid-descr-addr" but has _DSM combination.

I will use the name i2c-hid-acpi-prp0001, without DMI matching.
The new driver will first check whether "hid-descr-addr" is
present and silently return -ENODEV if so, falling back to _DSM
only when the property is missing.

I am testing the new driver and will send it out once verified.

The TPD0 node is identical on the N60d and CP300L3:

    Device (TPD0)
    {
        Name (_HID, "PRP0001")
        Name (_DSD, Package (0x02)
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package (0x01)
            {
                Package (0x02)
                {
                    "compatible",
                    "hid-over-i2c"
                }
            }
        })
        Name (_CRS, ResourceTemplate ()
        {
            I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                AddressingMode7Bit, "\\_SB.I2C1",
                0x00, ResourceConsumer, , Exclusive,
                )
            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
            {
                0x0000007F,
            }
        })
        Method (_DSM, 4, Serialized)
        {
            Switch (Arg0)
            {
                Case (ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de"))
                {
                    Switch (Arg1)
                    {
                        Case (One)
                        {
                            Switch (Arg2)
                            {
                                Case (One)
                                {
                                    Return (0x20)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

Regards,
Zhibang

