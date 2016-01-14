From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Fwd: ALPS v7 TrackStick detected wrongly
Date: Thu, 14 Jan 2016 13:11:18 +0100
Message-ID: <20160114121118.GU11560@pali>
References: <1452773083.4165.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35253 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcANMLV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jan 2016 07:11:21 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so340681443wmf.0
        for <linux-input@vger.kernel.org>; Thu, 14 Jan 2016 04:11:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452773083.4165.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Martin <madstitz@gmail.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi!

I'm Forwarding to linux-input. Looks like there can be problem with
TPPS2 protocol detection on ThinkPad laptop. Any idea?

-- 
Pali Rohár
pali.rohar@gmail.com

--AqsLC8rIMeq19msA
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: pali.rohar@gmail.com
Received: by 10.13.238.5 with SMTP id x5csp4076697ywe;
        Thu, 14 Jan 2016 04:04:46 -0800 (PST)
X-Received: by 10.194.82.229 with SMTP id l5mr4259100wjy.140.1452773086172;
        Thu, 14 Jan 2016 04:04:46 -0800 (PST)
Return-Path: <madstitz@gmail.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by mx.google.com with ESMTPS id lh1si691580wjc.78.2016.01.14.04.04.45
        for <pali.rohar@gmail.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2016 04:04:46 -0800 (PST)
Received-SPF: pass (google.com: domain of madstitz@gmail.com designates 2a00:1450:400c:c09::22d as permitted sender) client-ip=2a00:1450:400c:c09::22d;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of madstitz@gmail.com designates 2a00:1450:400c:c09::22d as permitted sender) smtp.mailfrom=madstitz@gmail.com;
       dkim=pass header.i=@gmail.com;
       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Received: by mail-wm0-x22d.google.com with SMTP id b14so361183859wmb.1
        for <pali.rohar@gmail.com>; Thu, 14 Jan 2016 04:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:subject:to:message-id:mime-version:content-type;
        bh=be7sflDR7+mB7KwKLD3a8uPxyoTg7HSdn+SIcVw3a7A=;
        b=AnPmFyosw1RzfXXZ2N3/aoNutsSk4ALp27Ws2AipepNcfbbt6YcF3VqRgWaKqvyJcO
         TKQSG2ExGygZxz0R4li8/xP4KQBxoSIMS8uKhgCdxv0g3/rv/jzQEvLaUVDLXyU765I+
         dmuOBjpORIZn7e+5CIekm9fjP+cQsGHb3mMKMyEM3BUNF1WbV533e9pduQFT4HP7ltx+
         axbZKxhkWf+GxDhYbIAE0z1N5LXKmKtWCrFWO6iay/Gw5z2mN/Cab/7qDqUBHO9p4y59
         PfO91w6/abcmOy7UDzblYFZvbeoSqoVJjGbM6de0uFGU0KNxjWgtBz+3zWW4g9NQAXBs
         YtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:message-id:mime-version
         :content-type;
        bh=be7sflDR7+mB7KwKLD3a8uPxyoTg7HSdn+SIcVw3a7A=;
        b=bHegmh9qtHK/GEpIa/H1ZOEI4kQkfYaiIl9bn9NQqI9piu158ofgOSqejXTDO4+2Qh
         vSPk+8ppkWEJD5u4RZ0lH4vA8lKp7My7BCku9eTUly4f//sxYBhK1jKWGOcdjLiXT1So
         1lY+6jTg3PwvXfjOq6MRZ1A1v4TRkCGgNfTfsKjIuIkT+K59uhjuaOtCHGpKJS+eM+9x
         ujgr7cFr3dVfjC4Xunskx16g7FpFbiOMgSVnRDmzCLi01f6WhFUjR49w4wz52AnCL/0g
         ksLVJyRvAfzHbNk/1A4fJhmpvX1KZMoGMi9IOwa3gSrcr12zW9fVQNah9/edhQGhaSo9
         MNsA==
X-Gm-Message-State: ALoCoQmtqnxdQ6Bq52ZA7DmletIia4eZh48vi0sd0mwb0qFUuEj/+YjBoo8heW/YWH/ulMOWk0dumAPuRFl4rxbt1Wj80g81ZA==
X-Received: by 10.194.115.129 with SMTP id jo1mr3737274wjb.28.1452773085827;
        Thu, 14 Jan 2016 04:04:45 -0800 (PST)
Return-Path: <madstitz@gmail.com>
Received: from s5020.dyn.hrz.tu-darmstadt.de (s5020.dyn.hrz.tu-darmstadt.de. [130.83.219.252])
        by smtp.gmail.com with ESMTPSA id qs1sm5822643wjc.2.2016.01.14.04.04.44
        for <pali.rohar@gmail.com>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 04:04:44 -0800 (PST)
Date: Thu, 14 Jan 2016 13:04:43 +0100
From: Martin <madstitz@gmail.com>
Subject: ALPS v7 TrackStick detected wrongly
To: pali.rohar@gmail.com
Message-Id: <1452773083.4165.0@smtp.gmail.com>
X-Mailer: geary/0.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed

Hi Mr. Rohar,

I just read about your commit for kernel 4.5 ("Input: ALPS - detect 
trackstick presence for v7 protocol"),
and was wondering if this is addressing a problem I have:

I recently replaced the touchpad of my ThinkPad S440 with the one from 
the T450 (because of the dedicated trackstick buttons).
The touchpad is working fine (including the dedicated buttons), but the 
trackstick doesn't work anymore.

I suspect this is because it is detected incorrectly as an "AlpsPS/2 
ALPS DualPoint Stick" when it should be (and previously was detected 
as) an "TPPS/2 IBM TrackPoint" (checked with other S440 owner).
A friend replaced his T440 touchpad with a T450 touchpad from 
synaptics, and his trackpoint is working fine.

Relevant output of
cat /proc/bus/input/devices

I: Bus=0011 Vendor=0002 Product=0008 Version=0700
N: Name="AlpsPS/2 ALPS DualPoint Stick"
P: Phys=isa0060/serio1/input1
S: Sysfs=/devices/platform/i8042/serio1/input/input8
U: Uniq=
H: Handlers=mouse0 event6
B: PROP=21
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0008 Version=0700
N: Name="AlpsPS/2 ALPS DualPoint TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input5
U: Uniq=
H: Handlers=mouse1 event7
B: PROP=5
B: EV=b
B: KEY=e520 10000 0 0 0 0
B: ABS=260800000000003

I: Bus=0019 Vendor=17aa Product=5054 Version=4101
N: Name="ThinkPad Extra Buttons"
P: Phys=thinkpad_acpi/input0
S: Sysfs=/devices/platform/thinkpad_acpi/input/input9
U: Uniq=
H: Handlers=kbd event8 rfkill
B: PROP=0
B: EV=13
B: KEY=10040 0 18040000 0 10000000000000 0 1501b02102004 
c000280041114000 10e000000000000 0
B: MSC=10


Is your patch intended to solve this or should I open a bug ticket?

Thank you very much for your time!

Greetings
Martin Stitz


--AqsLC8rIMeq19msA--
