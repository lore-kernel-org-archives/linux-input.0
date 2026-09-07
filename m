Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AE3BAD9A
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814239; cv=none; b=ki2IwDkxX3RZ5q8nTtdzfGrElxcphe3vz7kjVcPXWPse28vd+dQwsIvqn89K4/D7IyKtXt3JFsoyfAZ+L10KbkJX11lK/Ql8cXljbTAh1RIRL5XgBxtu3qQLY+l2gnbQaqMkcGn8gpGCWjQ+TyZ3WK2hjFqKlV05VAI2bmrNTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814239; c=relaxed/simple;
	bh=J4pCQZJgm2dE+4L8MOiPCH66HA1hlwNZZZjnbQkdENI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8B8EC3vgdWNUytP5GnZwD5+uIxiZ5zBiHNZJv7ZGiXMtZ9KprstzxrlWXA89ZqQjAJnAQQlpTC9pfxyjkKhvqyIF3EqwLZnvpiESseKY9icgdqa5BKUSHeGxlsNfw0D67ZM8hNWBgaxIjWKz5FEUpON0lp3XkqTe2EMNd8eaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih3cleus; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih3cleus"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84864086bfeso3408402b3a.1
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814238; x=1789419038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nsixEv23b14+93tpF7Zi+UwN7prwGg8DzwEVHkEb3zk=;
        b=Ih3cleusc8Ixi6vd47GxiemmBymnD3lvcquelEHWzA+GZcUZb6tcvXrpSVqA9kib80
         ZkXp9297e8rayBMgOj1wrZyZBF0lFecj+s+WvDdvaJzysMSAeWRDQwhf+ZzrX12+id/3
         Oy2yJ45NsSYN91/jlnwaDEZeZ3gJwQ2qhVjWs0zUuN4G8gllA8+4nKrFQ1BlsuDn+qG7
         ZPcw6P5kg3r7p2LaDxL9CetZI/ID1vPcVf6ZvtqNWbhR5j4y4yjwHO1cQ5VyVNO8jD6j
         GYXisyhisBMJQsMZR7WmrhRrqMY/zMx5qGpqeC5dsDGZH61ZlyibIt39kb+Qw0s1gLnX
         ye5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814238; x=1789419038;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nsixEv23b14+93tpF7Zi+UwN7prwGg8DzwEVHkEb3zk=;
        b=ZDX2Zw9HNZxgUH51PbhM2x5k6RybDqNLdZj04jN/x+/Hw39JRw8HFFZ0E8Jd/62/Ym
         zZzof3QbtEm39CN2voedvcSz8o2naCV/Dh7Lbs3fBMqSn3Mo+APub3hi76aa+STedD3u
         Jp7HDgMjL8d/YeF9mXAJ+bpRD+MoqBoBtMxMuI05gA2nRxuzTykDexUCdxn7kFHb8ChV
         nS4dM3PT5BER8MWrvtDsWJ2ySU+6qAvwQFAT2T3chsFrOS4ZkbEKkjjDyZje4yMRs4jv
         XzVhrP1fvOghvvIK9+adDT5ReXnnsMZYwaXRLLFci+kLXlBdAE3nVd05ppzA4OlaIXNr
         IdtQ==
X-Forwarded-Encrypted: i=1; AKwUvByxdmDfXvo0MMfej/vAL6Er7aTniZazxiGTKPHueScODEnBBBf2WBZ7LdqeinS4ZML1remiFa56onIiog==@vger.kernel.org
X-Gm-Message-State: AFuF++mXSGT5WpLSAZ36hW4CzrWctacEIhFlj6lpeQablrcBtn9WrfmK
	IEcRmqjw08Q7P6lrHddCYlylkrCGJ9m5AO0Q1jS1T4U5SKhhn2CwSj7a
X-Gm-Gg: AYBFou1BnSPuaUYsVkAAwgqG6ECcwJ4ag0wnym7QI+/XGzEyUzc57JOBmlwaIuEJlI4
	fQrbPz4J5hJMCYtX7bfHztT6Nwfn+qv5HAtnIH94nZhpQExS73ZM2/XZ9aV2W/Q5v1TDwACVs1/
	vIJKXXa+ULDRnu+/DvCYJYS1xy+bWyLoY43rYjtCJdunEeT9WRuI9AXQ1RqmxH98FbjXTRWom7s
	a5hLO2ZDE3IPw5IM+DzW/06nDSQDEZACLfp+a/Fcq6sRm0IXdBL02oOCQt0GLNvJLfFayL+0Yq6
	GfbXbeeHAlRXMQA2GpYQB/zwqmcpZkSgO08druknKZ1fCTsqa7zV10hCzs5T1CJttkOOqJ1fCSe
	Y5Ket3vI5he5zpMzIbx1XyfAh7dKVqZcPdVD1cD9CbJk4Gzn+JKrfyCKA3VHBarQbbH9vyaYfYp
	VpQGRzpYaQPF59W6kVgk5wOQ7dKWgB6HB+kfYn1vzioJNTRcR5m9nkWjhZKqBIdw16zYMlXWsXM
	sqNExDM0Z91SvmX6VdfU3JH1gjI
X-Received: by 2002:a05:6a21:748e:b0:3d2:5eb3:596 with SMTP id adf61e73a8af0-3da3a043152mr38526367637.16.1788814237511;
        Mon, 07 Sep 2026 13:50:37 -0700 (PDT)
Received: from localhost ([2409:40c4:ed:964b:4e88:5fd3:6ed7:a9fd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434bb7d71fsm361998c88.15.2026.09.07.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:50:36 -0700 (PDT)
Date: Tue, 8 Sep 2026 02:20:31 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Adam <testyiprywatnosc@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
Message-ID: <ap8JsxbZDmWxigZv@eggarch>
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
 <aoC-aI_7Dq_nJTHg@eggarch>
 <CAEru=6K=P_oJfksvRf2BfHZF9AFrQD4=izAwrSsz_Xit_i96xA@mail.gmail.com>
 <CAEru=6+Lnwn+UHcpGA29gcET=ERgiYCOqkR0ijShcfOFR1m-1g@mail.gmail.com>
 <CAEru=6K8gYwNWHFoYmwpQY8GGJ3HrqoJxKyu41nSSGQWOTVOdw@mail.gmail.com>
 <aoyO68JLUeCZbStK@eggarch>
 <CAEru=6JrUqo34ZtDES+VE3vbLGAFYd5UjnrpLOELKoEVg1Zx=A@mail.gmail.com>
 <CAEru=6+AJAJDw4uCi0=HFXH8XrOQhixHFk2e__o+hdd1m1ju5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEru=6+AJAJDw4uCi0=HFXH8XrOQhixHFk2e__o+hdd1m1ju5A@mail.gmail.com>

On Sat, Sep 05, 2026 at 10:25:46AM +0200, Adam wrote:
> One more finding, potentially significant: I found that holding/tapping
> F9 at boot (HP's boot menu) repeatedly, or alternatively entering the
> UEFI Firmware Settings from GRUB and immediately continuing boot, gives
> the touchpad a reliable, working boot on my Ubuntu installation
> (tested this handful of times, consistently works).
Hmm.. I guess the f9 trick just moves probe's luck, nothing more.

I wonder what would happen if we added a good amount of bounded
retries on -EREMOTEIO and -EIO errors on the two reads
[i2c_hid_fetch_hid_descriptor(), i2c_hid_parse()] retries are
missing. I suppose firmware still responds to reads but NACKs any
write during the 'unresponsive' window which lasts far longer than
current retries can cover.

Could you test a patch below with dyndbg enabled, on a mix of warm/cold
boots, see if it improves this situation, if some boots still fail,
include their probe timestamps.

Also, on windows, does it start working immediatly after boot on all boots?


diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 0ff07fdab442..b0e8e2cc24ff 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -241,6 +241,30 @@ static int i2c_hid_read_register(struct i2c_hid *ihid, __le16 reg,
 	return i2c_hid_xfer(ihid, ihid->cmdbuf, sizeof(__le16), buf, len);
 }
 
+#define I2C_HID_DESC_FETCH_TRIES 10
+
+static int i2c_hid_read_register_retry(struct i2c_hid *ihid, __le16 reg, void *buf, size_t len) {
+	int error;
+	int i;
+
+	for(i = 0; i < I2C_HID_DESC_FETCH_TRIES; i++){
+		if(i){
+			msleep(1000);
+
+			if(i2c_hid_probe_address(ihid) < 0)
+				continue;
+		}
+
+		error = i2c_hid_read_register(ihid, reg, buf, len);
+		if(!error || (error != -EREMOTEIO && error != -EIO))
+			break;
+
+		i2c_hid_dbg(ihid, "register read failed (%d), retrying\n", error);
+	}
+
+	return error;
+}
+
 static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
 				     int report_type, int report_id)
 {
@@ -790,9 +814,7 @@ static int i2c_hid_parse(struct hid_device *hid)
 
 		i2c_hid_dbg(ihid, "asking HID report descriptor\n");
 
-		ret = i2c_hid_read_register(ihid,
-					    ihid->hdesc.wReportDescRegister,
-					    rdesc, rsize);
+		ret = i2c_hid_read_register_retry(ihid, ihid->hdesc.wReportDescRegister, rdesc, rsize);
 		if (ret) {
 			dev_err(&client->dev, "reading report descriptor failed\n");
 			goto out;
@@ -909,10 +931,9 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 			*i2c_hid_get_dmi_i2c_hid_desc_override(client->name);
 	} else {
 		i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
-		error = i2c_hid_read_register(ihid,
-					      ihid->wHIDDescRegister,
-					      &ihid->hdesc,
-					      sizeof(ihid->hdesc));
+
+		error = i2c_hid_read_register_retry(ihid, ihid->wHIDDescRegister, &ihid->hdesc, sizeof(ihid->hdesc));
+
 		if (error) {
 			dev_err(&ihid->client->dev,
 				"failed to fetch HID descriptor: %d\n",
