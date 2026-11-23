Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426106;
	b=i2tYWK0KU3MmibuvV/+8WDbhzQriG0lFWFf97YnkgEkWZ3CE8XKeNyOF/sgYzkTEImD+
	 0v/NQCG9UAJld5mEvggq7bXzjiM0KuWnTBwBafpQQFNXmq8QrbgfgssKEFsqK3xoy/V+e
	 EjoY1IpDRzi7l/KI4R7v6BEiYAH2Kk9s5vw+kiQH1JJbRxcBPgUmY6fO9x3eABXU7+agA
	 KQut5zc/rAvl/YT+g+IvkR4gMEF8bAwPnkwxkXxPTaCvqXy211mnaJb9Nu98lME8hUPJM
	 TLFvzZDi4N5VwkiWt7MNscYUHBZr8bM80TmYExycRNySDwP88ur0DZzoonM0/jM1ZuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
	b=TXrnyr9XJ8/C+xN/DZ/BXs1sCJt0oKNJPk/8PxvWXw4P4d2fxtpKMJP+tz7/I+v8NXy3
	 VGmM990DTvSKgAg7B6qlaFkVdq7TCxmfSOZGiqOQkNxDNI6nv9VRz+AFH/AmG0ymgiZ/K
	 O5KKn9n0yQ1I+wsnR9ou0CYyKhOKD8Tb7cyTrzMITEW3ECX6yq7H1HAEBhHD6ZlFUBapR
	 9TL73kqD1yfM0Gdij0o/lgzdX8T0FFHN8ejgWd2Gi1lmpkyP8uqmt/Dg4luJdE/NUgT/v
	 pF69Qk7w0pq/3JemN6z8OU4BQFkOSYbPcr2AbGgKszAuLphts4nZYOCgDS2ttUYKITA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KonRzl74;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A80606A337
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 09:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A80606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KonRzl74
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so4200244c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426104; x=1796030904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
        b=KonRzl74XuVsyONQ5BC9tePVp835nCUourDadESPVPQNurQGyV0Gg6QkRUt2wlQP9G
         bTgRQkGYczWbaCIg+dfrxapDzGftCnZjr8CxMlgKn4BUX+khuOubhAUoTViRNfpxKT9m
         pFLCIqrvaJ0taIH/faDWUGp+G9kYi7TMxxsTJWY/OUuwWl71t/iRDDpDdpOn6GQouaSI
         Gs16HE0tyLWO+R4H3Xh//oXf7Oohy4Ee4a3kk5go+j79u2HmPV3/ayV5LsInYCGvVICe
         ZZN4hrhzq34bYZElaj1GuCi1BkmRy46KBtjYV/9xFt9xNQuvTOMHR6/Fe/MTox8mdqob
         MS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426104; x=1796030904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eqY5M+833O7wLNRlvkDeBl1muWO4amje1VZmhdt6f8=;
        b=gWs5aDh5gKvql/ooPoY7n+73iBj5+EQ2HYrsDXAiQO8wKR4e5JO2S0KzebD/AAsgW9
         ahIYtJrQyJHoQLbamqM2VNGQURQ/Cd4+P+8TltFeCy4HYDs9tUg8zgdYvC0WJV0KYe4b
         zzHBJ6WVZpWpfe1OV3tVLmFg/qCNZ6uVuvrJeievlOVX/QLUN0LWWP5aVQrvwsFUYErI
         kzC3gnLy8gfWBlAnbRk6Ls3v74hN8t0Y8nXUf4LgTtkfm4pT7OOb7vxWy2GUoVDWbpJp
         R7je9x8/+CBBcb0OKsjgU1q3vXUQeIVOOxzN1AmoKiqL5iP5UOlKyWxpJH6mVaFQtjJM
         nTqw==
X-Forwarded-Encrypted: i=1; AL+hErFjVnEj2aIHBHs/kyxG20FPJ+HInddxuDDmX0gvWzMQKYtXEZdAEVH17LpAWC2MkNObG8rWCv0P9BL/rQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z98BkUSl/Bg36p1UDls1ApjKd4MltC6MVI0rVke5SfQVFXJeYOm
	6DSX7XD3a1kt8Q5ooUHfy+M6q5A0VRMQ1Ypef1nuNVJdpkPrWGPzVrQM
X-Gm-Gg: AZFdTZfWVx62LDEkiz0LURJRTRQ8aw6kygl7QrxVa9LM0Ql2/phQnPKCpizZ5uvVrBy
	W0edj7mLHTctlKVZEVgI9uWN5xrYfnXhHwBsGa+KgvpmIWW28VGmtUBs1hgMfwm2ic7gSlA+zDO
	Yz0sUezJolGykmZv0OHVtOIF7UGGxAHC448E7AjpqHzQGZ8uZiyYydugsalHfgOtxziJ7dWXX7c
	cCuau66CXHCdJMPoEiRMmIs0SLHcfQ/qw7//b9Tp7qmkvRoIk3X95myS3f2JCUW/QEVAaOMn9P1
	utm1OhEgigeT+xlKaVKa0yTDTG2p86pZZZpkrSlzHI2gbDIIqQ4nnU6hvjfPxs9y4aT7dZD1sDg
	V6ZosOFDHQKS21+BSQhfWSCueRdOkns4J3CpWsQaPT9+q8NE8cDi7CxUeWamJeB3XOYtg7QKecV
	Q/qp+lyNwgxcLtzAEycLGfIr0DKjSdLDr1T6H0AuK3KMXw/IMy3gEy/krYvdgAY4nCIzVxSofg7
	pVUmr0IiT1fph/sHdufFEfZmCpZEYdqJrvXilycqfYbHgQR8zJ9HDQOvLBkzZFNp81ydUxTMAIo
	7VeNeurpccdZQ77yCAz0L9MmaVpwSKflehwaxtrBAXX4Xr7INpzMSA==
X-Received: by 2002:a05:701a:cc91:20b0:1b5:7148:95b5 with SMTP id a92af1059eb24-1b571489632mr2871767c88.8.1795426104066;
        Mon, 23 Nov 2026 01:28:24 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm19861941c88.11.2026.11.23.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:28:23 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] HID: intel-ish-hid: Reallocate hid_devices for a larger device count
Date: Mon, 23 Nov 2026 17:28:16 +0800
Message-Id: <20261123092816.2200718-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
References: <20261123092816.2200718-1-maoyixie.tju@gmail.com>
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

process_recv() allocates hid_devices only when it is NULL, with the
count of the first ENUM_DEVICES response. It then copies as many
entries as each response announces. After an ISH reset, a larger count
can write past the array. A second response with a larger count does
the same. After a first response with no devices, the next copy writes
at ZERO_SIZE_PTR.

Size the array to the announced count with devm_krealloc_array() before
the copy, and update hid_dev_count only when that succeeds. A count of
zero keeps the old array as before, since hid_ishtp_cl_init() may still
read it.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer, which reports
none of these writes with this patch. Not tested on hardware, only
compile-tested with W=1 on hid.git for-7.4/upstream-fixes.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 24f4032d6dfe..864a06a7bd3f 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -70,6 +70,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	unsigned char *payload;
 	unsigned char *descr;
 	struct device_info *dev_info;
+	struct device_info *devices;
+	unsigned int count;
 	int i, j;
 	size_t	payload_len, total_len, cur_pos, raw_len, msg_len;
 	int report_type;
@@ -124,19 +126,21 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			}
 			if (client_data->init_done)
 				break;
-			client_data->hid_dev_count = (unsigned int)*payload;
-			if (!client_data->hid_devices)
-				client_data->hid_devices = devm_kcalloc(
-						cl_data_to_dev(client_data),
-						client_data->hid_dev_count,
-						sizeof(struct device_info),
-						GFP_KERNEL);
-			if (!client_data->hid_devices) {
+			count = *payload;
+			devices = client_data->hid_devices;
+			if (count || !devices)
+				devices = devm_krealloc_array(cl_data_to_dev(client_data),
+							      devices, count,
+							      sizeof(struct device_info),
+							      GFP_KERNEL | __GFP_ZERO);
+			if (!devices) {
 				dev_err(cl_data_to_dev(client_data),
 				"Mem alloc failed for hid device info\n");
 				wake_up_interruptible(&client_data->init_wait);
 				break;
 			}
+			client_data->hid_devices = devices;
+			client_data->hid_dev_count = count;
 			for (i = 0; i < client_data->hid_dev_count; ++i) {
 				if (1 + sizeof(struct device_info) * i >=
 						payload_len) {
-- 
2.34.1

