Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726905;
	b=ladNFU1r+dtw8szSi3e6tK8kIh+e5XSjArum5vJXFPpHV1k74OlpWf9qRpfCvZYkjDTB
	 VarZQYDig0CKpJC0k1gsvzsm4UPTZwQUcHWwIVjKhkrpyfTKtgD2wYKniTBqP4q7gSL8I
	 laorPJkgDJyQ9lStYcAjiFpifpyU9Xytu4lccttWjkA/+yto0LaOSAzUO3d0V2cCrUb6r
	 qL/jDXWAuJSIvZbR3aYy7xOx/D2zcl7y+W8DmvsvW3uRIC6V7ec9gtF9NsfNJ++vCWAgx
	 b5xgTm2neHZ/gFlHsRf2JknaVsb4/qeqIYsRsq6nwddigBVpwmcT5y3GxSkEeI/4nEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=SDN1n4uWC0gN+j1XM+6pdDJbmUtd+35X2fZkfJwn2/E=;
	b=JhAAYEac5C6r9s4mLyjC8L3aP1arfoPMYCjUvVBFHIGjIL8FcQ7cXfp8L4ssOoc5V364
	 lNg/N8WVzo7Eq39TCp1C++nS2OqT5rTAEhKBsWgBLNEN+CeFDNhIA7kzUol82pmbxPuKf
	 VvKLMFi66A+ZEv9zoF1p9nCKsjYm1bKWXQveDsaFEKPXcxHvZUAVC793Ubf4F+DZcjuon
	 QZi2ylqYJcCjr+NNZKJ3h7Zw7dSt2k6uf6F+wNqL5bFtaSFzxGTny46p1hI7GaFYX5hSl
	 Lc/0jh6913xQZOOevWE4RDiC/Z3fB5dk6wn5zZ7u+30VInOMd5ptplgKWhX+g7/7uQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfetBBgL;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC5606A31A
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8AC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfetBBgL
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37986eb6fa2so2477844eec.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726904; x=1795331704; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SDN1n4uWC0gN+j1XM+6pdDJbmUtd+35X2fZkfJwn2/E=;
        b=GfetBBgLfdS+zqlExlKRLSeDB1EW6GEz9sfHilxit/eS2JABzQJDTDvHtgCmABwuBB
         wPQGYspc4MF16yY2OEkeFBK0KIJ0BFVEZ7Kn6nJcCwz2TdSl5//4ZBawzjczrcS+RmE6
         arwpyCi6ieeT1q9yr+iarDqlsYV8rmfKOvfttOqDivUvep8NajFrpAnHDKKrvHkH87M5
         3S3OZ8dvrsKrTzLsyB8bRXpl35G6R8iR7daQzvT7YSlvekkyV8xZR+MwX9F8Kk7Hz2tW
         CZlL6ydrMuq9FRZe3GXs+YdoWbEPdWRZY23U9cagarjTxwr4itkctzsXVS9aMyVtgL2W
         wF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726904; x=1795331704;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SDN1n4uWC0gN+j1XM+6pdDJbmUtd+35X2fZkfJwn2/E=;
        b=IUi6Oh34cdNxNFfpwWCLELJu4qHKzSM8MApsjzwa74WQhBISD7GeNzufVlkbXM400l
         aQqsP+pmUpmhntezJwq4puY/rgInfwJ7NGhG9Xf3AwwY9gs9NEph4LnwDkcE1iAZsBSP
         2IH06V26+hV189QgkRORjAeBtcEKXtOYwOuDvtqLXjovmKNHqi3SLJ6ceZKIiS4ZsbBj
         eYj69U5j6GsWcduESmdWHH/T9Znn49a00wGJ/zRoFA+4XKsuw2N/KHMGG7ymYDt+EqT0
         RTh0iQ9bVQerFRoMYmwmSP6zholUQsgRkpv9t61DaeP4QJ/NusRt21nK2sfxbVsph10Z
         9BYQ==
X-Forwarded-Encrypted: i=1; AL+hErGvJc56N06psNtKDHje040IL6u3vCVswvV93Q0jzbYdeapo0PSHZa9IQamdZRnB97BSci3zWtd4hRmIBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZUxX7m4AClXtY4w9ju2M4164LHXzXG46V/FgsATq2BdKvDOgs
	eCkj84OHecrGVks6V6+5zCKCtEShfzjfnHrCPk5+DCaTfcdcZ4Fb0Ig3uA2sFA==
X-Gm-Gg: AYBFou3L9OVEs3Yd/gfLK7OMUcLfM66h9pwZvWaklFbcwNTl7jWw7gWbxjKhsVwwpKo
	2Im2YtgjYIvxfTDVIjXkPw1VRB0QXmB1YBimW/ylGBQCRZXeXasslFzXxoQKcUkFRhNgSrTW/QR
	/c/H8pCOlVxdZDLSVZX/Lkb9f385YeMTiXxmUCAM15GNQpQKGrqjUP5upI+Or0U7NqfxGtfXcxE
	diqqQ0nDYCl6+54q7N2tf4yCg5wgSo9doPMVG5k1NOL0pyoszCOZ7yeBS9JKRoIZDaqx/X6Y4wQ
	l1fkui2WMUJZtIFBMQUKsBY8JdCP8MiJDMOFAg6bpminUYq6IG+of8eahcL0n0OJGmMtYQDkiTf
	18gXU9hvVTdYxDNrj6lxnfwW1vYGcE2DoJYQfY1rYBHdLAuP0eHipJU74cfADFP52Fm66DT2G7/
	OdEAs8TD6kctTqeiaqNMfBvF57mjF1VqIIX9GsbjizoQPk54LyVv2HyXDfmagoGudctFg1ZHIAH
	OFcIEyBOG9ALjDGDH1yXYuwKRJEqOlb12S3Jq7p5TfNS9T9sBkkibN8rjhcAKR/GiYJKTxy1QK+
	WFcn65InFn6BfnqH64bcHXZuvt1CjvkVX7mD8v8t3W8GKKVvU0ATrwXlbwjBVbuxgu4w
X-Received: by 2002:a05:7300:86:b0:375:be89:8a47 with SMTP id 5a478bee46e88-3796740b880mr7933263eec.27.1794726903737;
        Sat, 14 Nov 2026 23:15:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:203f:d9b9:dda8:24e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm23649458eec.14.2026.11.14.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:15:02 -0800 (PST)
Date: Sat, 14 Nov 2026 23:15:02 -0800
Message-ID: <a7479a7fe967e4acc9fe14396e154e05@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Green <n.grn@outlook.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [REPORT] synaptics_intertouch on ThinkPad T14 Gen 2 (LEN2072)
In-Reply-To: <CY8PR02MB9252BB9E8D3ECA0AE81249A2E77D2@CY8PR02MB9252.namprd02.prod.outlook.com>
References: <CY8PR02MB9252B5E325192960631C286CE7AB2@CY8PR02MB9252.namprd02.prod.outlook.com> <b51b774b36066fb9aea14fdcf192c3b1@gmail.com> <CY8PR02MB9252BB9E8D3ECA0AE81249A2E77D2@CY8PR02MB9252.namprd02.prod.outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Nick,

On Sun, Nov 15, 2026 at 03:14:04AM +0000, Nick Green wrote:
> Thanks for following up. I tested patches 1-2 on 7.3.3 (Fedora) with
> psmouse.synaptics_intertouch=1 on my ThinkPad T14 Gen 2i (LEN2072). The
> patched rmi_core was confirmed loaded, but tap-to-click is still
> unreliable: in a raw evdev capture, only 7 of 20 taps produced any touch
> events at the kernel level. PS/2 mode remains reliable on this machine.
>
> Since patch 3 adds LEN2072 to smbus_pnp_ids, this machine would move to
> SMBus by default and regress tap-to-click. Could LEN2072 be left out of
> the list, or limited to the P14s Gen 2i, until the tap issue is
> understood?

Let's first try to figure out what is going on with the missed taps on
your machine before deciding whether we need to drop LEN2072 from
smbus_pnp_ids.

To help narrow down whether the missed taps are not generating an
interrupt at all (for example due to F01 doze/wakeup threshold settings
or missing F12 dribble packets) or whether the interrupt fires and the
F12 Data1 packet is already cleared or reporting an unhandled object
type by the time the SMBus read completes, could you please apply the
debug patch below (against v7.3) and test with full RMI4 debug logging
enabled?

Please boot with:

  psmouse.synaptics_intertouch=1 rmi_core.debug_flags=0xf

(or set /sys/module/rmi_core/parameters/debug_flags to 0xf before
rmi_smbus probes the touchpad so the initialization logs are also
captured), then perform a handful of deliberate single taps, noting how
many registered vs. missed, and send over the resulting dmesg output.

Thanks.

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index ea3eb87a89af..135d5de1973b 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -70,12 +70,14 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
 {
 	struct rmi_2d_axis_alignment *axis_align = &sensor->axis_align;
 	struct input_dev *input = sensor->input;
+	int mt_slot = sensor->kernel_tracking ?
+		sensor->tracking_slots[slot] : slot;
+	bool was_active = input->mt && mt_slot >= 0 &&
+		mt_slot < input->mt->num_slots &&
+		input_mt_is_active(&input->mt->slots[mt_slot]);
 	int wide, major, minor;
 
-	if (sensor->kernel_tracking)
-		input_mt_slot(input, sensor->tracking_slots[slot]);
-	else
-		input_mt_slot(input, slot);
+	input_mt_slot(input, mt_slot);
 
 	input_mt_report_slot_state(input, obj->mt_tool,
 				   obj->type != RMI_2D_OBJECT_NONE);
@@ -104,9 +106,13 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
 		input_event(sensor->input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
 		rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->input->dev,
-			"%s: obj[%d]: type: 0x%02x X: %d Y: %d Z: %d WX: %d WY: %d\n",
-			__func__, slot, obj->type, obj->x, obj->y, obj->z,
-			obj->wx, obj->wy);
+			"%s: obj[%d] (mt_slot=%d was_active=%d): type: 0x%02x X: %d Y: %d Z: %d WX: %d WY: %d\n",
+			__func__, slot, mt_slot, was_active, obj->type,
+			obj->x, obj->y, obj->z, obj->wx, obj->wy);
+	} else {
+		rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->input->dev,
+			"%s: obj[%d] (mt_slot=%d was_active=%d): type: 0x%02x (NONE)\n",
+			__func__, slot, mt_slot, was_active, obj->type);
 	}
 }
 EXPORT_SYMBOL_GPL(rmi_2d_sensor_abs_report);
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a349dfd17519..05872ef93ef5 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -148,6 +148,10 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	}
 
 	mutex_lock(&data->irq_mutex);
+	rmi_dbg(RMI_DEBUG_CORE, dev,
+		"%s: raw irq_status=%*pb fn_irq_bits=%*pb\n",
+		__func__, data->irq_count, data->irq_status,
+		data->irq_count, data->fn_irq_bits);
 	bitmap_and(data->irq_status, data->irq_status, data->fn_irq_bits,
 	       data->irq_count);
 	/*
@@ -156,8 +160,19 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	 */
 	mutex_unlock(&data->irq_mutex);
 
-	for_each_set_bit(i, data->irq_status, data->irq_count)
-		handle_nested_irq(irq_find_mapping(data->irqdomain, i));
+	if (bitmap_empty(data->irq_status, data->irq_count))
+		rmi_dbg(RMI_DEBUG_CORE, dev,
+			"%s: interrupt fired with no active bits in fn_irq_bits\n",
+			__func__);
+
+	for_each_set_bit(i, data->irq_status, data->irq_count) {
+		unsigned int virq = irq_find_mapping(data->irqdomain, i);
+
+		rmi_dbg(RMI_DEBUG_CORE, dev,
+			"%s: dispatching irq bit %d (virq %u)\n",
+			__func__, i, virq);
+		handle_nested_irq(virq);
+	}
 
 	if (data->input)
 		input_sync(data->input);
@@ -384,14 +399,20 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 			data->f01_container->fd.control_base_addr + 1,
 			data->new_irq_mask, data->num_of_irq_regs);
 	if (error < 0) {
-		dev_err(dev, "%s: Failed to change enabled interrupts!",
-							__func__);
+		dev_err(dev, "%s: Failed to change enabled interrupts: %d\n",
+			__func__, error);
 		goto error_unlock;
 	}
 
 	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 	bitmap_or(data->fn_irq_bits, data->fn_irq_bits, mask, data->irq_count);
 
+	rmi_dbg(RMI_DEBUG_CORE, dev,
+		"%s: mask=%*pb irq_mask=%*pb fn_irq_bits=%*pb\n",
+		__func__, data->irq_count, mask,
+		data->irq_count, data->current_irq_mask,
+		data->irq_count, data->fn_irq_bits);
+
 error_unlock:
 	mutex_unlock(&data->irq_mutex);
 	return error;
@@ -410,12 +431,19 @@ static int rmi_driver_clear_irq_bits(struct rmi_device *rmi_dev,
 	bitmap_andnot(data->new_irq_mask,
 		  data->current_irq_mask, mask, data->irq_count);
 
+	rmi_dbg(RMI_DEBUG_CORE, dev,
+		"%s: mask=%*pb irq_mask=%*pb -> new_ints=%*pb (fn_irq_bits=%*pb)\n",
+		__func__, data->irq_count, mask,
+		data->irq_count, data->current_irq_mask,
+		data->irq_count, data->new_irq_mask,
+		data->irq_count, data->fn_irq_bits);
+
 	error = rmi_write_block(rmi_dev,
 			data->f01_container->fd.control_base_addr + 1,
 			data->new_irq_mask, data->num_of_irq_regs);
 	if (error < 0) {
-		dev_err(dev, "%s: Failed to change enabled interrupts!",
-							__func__);
+		dev_err(dev, "%s: Failed to change enabled interrupts: %d\n",
+			__func__, error);
 		goto error_unlock;
 	}
 
@@ -483,6 +511,14 @@ static int rmi_read_pdt_entry(struct rmi_device *rmi_dev,
 	entry->function_version = (buf[4] & RMI_PDT_FUNCTION_VERSION_MASK) >> 5;
 	entry->function_number = buf[5];
 
+	if (!RMI4_END_OF_PDT(entry->function_number))
+		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev,
+			"PDT %#06x: F%02X v%u irqs=%u query=%#04x cmd=%#04x ctrl=%#04x data=%#04x\n",
+			pdt_address, entry->function_number,
+			entry->function_version, entry->interrupt_source_count,
+			entry->query_base_addr, entry->command_base_addr,
+			entry->control_base_addr, entry->data_base_addr);
+
 	return 0;
 }
 
@@ -618,6 +654,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	unsigned int offset;
 	unsigned int num_registers;
 	unsigned int reg;
+	u16 desc_addr = addr;
 	int b;
 	int ret;
 
@@ -671,6 +708,13 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	rdesc->num_registers = bitmap_weight(presence_map,
 						RMI_REG_DESC_PRESENCE_BITS);
 
+	rmi_dbg(RMI_DEBUG_CORE, &d->dev,
+		"%s: addr=%#06x size_presence=%u struct_size=%lu num_regs=%u presence_map=%*pb\n",
+		__func__, desc_addr, size_presence_reg, rdesc->struct_size,
+		rdesc->num_registers,
+		min_t(int, map_offset, RMI_REG_DESC_PRESENCE_BITS),
+		presence_map);
+
 	rdesc->registers = devm_kcalloc(&d->dev,
 					rdesc->num_registers,
 					sizeof(struct rmi_register_desc_item),
@@ -697,32 +741,42 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	if (ret)
 		return ret;
 
+	rmi_dbg(RMI_DEBUG_CORE, &d->dev,
+		"%s: addr=%#06x struct_buf (%lu bytes): %*ph\n",
+		__func__, desc_addr, rdesc->struct_size,
+		(int)rdesc->struct_size, struct_buf);
+
 	offset = 0;
 	num_registers = 0;
 	for_each_set_bit(reg, presence_map, RMI_REG_DESC_PRESENCE_BITS) {
 		struct rmi_register_desc_item *item = &rdesc->registers[num_registers];
 		int item_size;
 
-		if (offset >= rdesc->struct_size)
+		if (offset >= rdesc->struct_size) {
+			rmi_dbg(RMI_DEBUG_CORE, &d->dev,
+				"%s: offset %u >= struct_size %lu at reg %u\n",
+				__func__, offset, rdesc->struct_size, reg);
 			break;
+		}
 
 		item_size = rmi_parse_register_desc_item(item,
 							 &struct_buf[offset],
 							 rdesc->struct_size - offset);
 		if (item_size < 0) {
 			dev_warn(&d->dev,
-				 "%s: Failed to parse register %d descriptor, ignoring it\n",
-				 __func__, reg);
+				 "%s: Failed to parse register %u descriptor (offset %u, struct_size %lu, err %d), ignoring it\n",
+				 __func__, reg, offset, rdesc->struct_size,
+				 item_size);
 			break;
 		}
 
 		item->reg = reg;
-		offset += item_size;
 
 		if (item->reg_size == 0) {
 			dev_warn(&d->dev,
-				 "%s: Register %d has 0 size, ignoring it\n",
-				 __func__, item->reg);
+				 "%s: Register %u has 0 size (offset %u, item_size %d, struct_size %lu), ignoring it\n",
+				 __func__, item->reg, offset, item_size,
+				 rdesc->struct_size);
 		} else {
 			rmi_dbg(RMI_DEBUG_CORE, &d->dev,
 				"%s: reg: %d reg size: %u subpackets: %d\n", __func__,
@@ -730,6 +784,8 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 
 			num_registers++;
 		}
+
+		offset += item_size;
 	}
 	rdesc->num_registers = num_registers;
 
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 47be64284b25..1bb78a16c529 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -415,6 +415,15 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		return error;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: initial ctrl0=%#04x (sleep_mode=%u nosleep=%d reportrate=%d configured=%d) pdata_nosleep=%d\n",
+		__func__, f01->device_control.ctrl0,
+		f01->device_control.ctrl0 & RMI_F01_CTRL0_SLEEP_MODE_MASK,
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT),
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_REPORTRATE_BIT),
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_CONFIGURED_BIT),
+		pdata->power_management.nosleep);
+
 	switch (pdata->power_management.nosleep) {
 	case RMI_REG_STATE_DEFAULT:
 		break;
@@ -447,6 +456,13 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		return error;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: wrote ctrl0=%#04x (sleep_mode=%u nosleep=%d reportrate=%d)\n",
+		__func__, f01->device_control.ctrl0,
+		f01->device_control.ctrl0 & RMI_F01_CTRL0_SLEEP_MODE_MASK,
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT),
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_REPORTRATE_BIT));
+
 	/* Dummy read in order to clear irqs */
 	error = rmi_read(rmi_dev, fn->fd.data_base_addr + 1, &temp);
 	if (error < 0) {
@@ -559,6 +575,18 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		return error;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: device_status=%#04x (code=%u unconfigured=%d bootloader=%d) adj_doze=%d adj_holdoff=%d doze_interval=%u wakeup_threshold=%u doze_holdoff=%u\n",
+		__func__, device_status,
+		RMI_F01_STATUS_CODE(device_status),
+		RMI_F01_STATUS_UNCONFIGURED(device_status),
+		!!RMI_F01_STATUS_BOOTLOADER(device_status),
+		f01->properties.has_adjustable_doze,
+		f01->properties.has_adjustable_doze_holdoff,
+		f01->device_control.doze_interval,
+		f01->device_control.wakeup_threshold,
+		f01->device_control.doze_holdoff);
+
 	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
 		dev_err(&fn->dev,
 			"Device was reset during configuration process, status: %#02x!\n",
@@ -625,6 +653,16 @@ static int rmi_f01_config(struct rmi_function *fn)
 		}
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: ctrl0=%#04x (sleep_mode=%u nosleep=%d reportrate=%d) doze_interval=%u wakeup_threshold=%u doze_holdoff=%u\n",
+		__func__, f01->device_control.ctrl0,
+		f01->device_control.ctrl0 & RMI_F01_CTRL0_SLEEP_MODE_MASK,
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT),
+		!!(f01->device_control.ctrl0 & RMI_F01_CTRL0_REPORTRATE_BIT),
+		f01->device_control.doze_interval,
+		f01->device_control.wakeup_threshold,
+		f01->device_control.doze_holdoff);
+
 	return 0;
 }
 
@@ -693,6 +731,13 @@ static irqreturn_t rmi_f01_attention(int irq, void *ctx)
 		return IRQ_RETVAL(error);
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: device_status=%#04x (code=%u unconfigured=%d bootloader=%d)\n",
+		__func__, device_status,
+		RMI_F01_STATUS_CODE(device_status),
+		RMI_F01_STATUS_UNCONFIGURED(device_status),
+		!!RMI_F01_STATUS_BOOTLOADER(device_status));
+
 	if (RMI_F01_STATUS_BOOTLOADER(device_status))
 		dev_warn(&fn->dev,
 			 "Device in bootloader mode, please update firmware\n");
diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 04f0e5578861..698ad2e35c96 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -77,7 +77,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
 	int error;
 
 	rmi_dbg(RMI_DEBUG_FN, &f03->fn->dev,
-		"%s: Wrote %.2hhx to PS/2 passthrough address",
+		"%s: Wrote %.2hhx to PS/2 passthrough address\n",
 		__func__, val);
 
 	error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr, val);
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 841884d967a3..2604ee354169 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -156,8 +156,12 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	}
 
 	/* When platform data are provided, we're done */
-	if (sensor->x_mm && sensor->y_mm)
+	if (sensor->x_mm && sensor->y_mm) {
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: x_mm: %d y_mm: %d (from pdata)\n",
+			__func__, sensor->x_mm, sensor->y_mm);
 		return 0;
+	}
 
 	/*
 	 * Use the Query DPM feature when the resolution query register
@@ -196,8 +200,10 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 			sensor->y_mm = (pitch_y * tx_receivers) >> 12;
 	}
 
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x_mm: %d y_mm: %d\n", __func__,
-		sensor->x_mm, sensor->y_mm);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: x_mm: %d y_mm: %d (dpm=%d pitch=%d/%d rx=%d tx=%d)\n",
+		__func__, sensor->x_mm, sensor->y_mm, dpm_resolution,
+		pitch_x, pitch_y, rx_receivers, tx_receivers);
 
 	return 0;
 }
@@ -206,15 +212,18 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)
 {
 	struct rmi_2d_sensor *sensor = &f12->sensor;
 	u32 objects = min(f12->data1->num_subpackets, size / F12_DATA1_BYTES_PER_OBJ);
+	u32 non_zero_objects = 0;
+	u32 active_objects = 0;
 	int i;
 
 	for (i = 0; i < objects; i++) {
 		struct rmi_2d_sensor_abs_object *obj = &sensor->objs[i];
+		u8 raw_type = data1[0];
 
 		obj->type = RMI_2D_OBJECT_NONE;
 		obj->mt_tool = MT_TOOL_FINGER;
 
-		switch (data1[0]) {
+		switch (raw_type) {
 		case RMI_F12_OBJECT_FINGER:
 			obj->type = RMI_2D_OBJECT_FINGER;
 			break;
@@ -229,8 +238,26 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)
 		case RMI_F12_OBJECT_UNCLASSIFIED:
 			obj->type = RMI_2D_OBJECT_UNCLASSIFIED;
 			break;
+		case RMI_F12_OBJECT_NONE:
+			break;
+		default:
+			rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->fn->dev,
+				"%s: slot %d: unhandled object type %#04x raw=(%*ph)\n",
+				__func__, i, raw_type,
+				F12_DATA1_BYTES_PER_OBJ, data1);
+			break;
 		}
 
+		if (raw_type != RMI_F12_OBJECT_NONE)
+			non_zero_objects++;
+		if (obj->type != RMI_2D_OBJECT_NONE)
+			active_objects++;
+
+		rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->fn->dev,
+			"%s: slot %d: raw_type=%#04x mapped_type=%d raw=(%*ph)\n",
+			__func__, i, raw_type, obj->type,
+			F12_DATA1_BYTES_PER_OBJ, data1);
+
 		obj->x = get_unaligned_le16(&data1[1]);
 		obj->y = get_unaligned_le16(&data1[3]);
 		obj->z = data1[5];
@@ -242,6 +269,10 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)
 		data1 += F12_DATA1_BYTES_PER_OBJ;
 	}
 
+	rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->fn->dev,
+		"%s: frame summary: active=%u non_zero=%u slots=%u\n",
+		__func__, active_objects, non_zero_objects, objects);
+
 	if (sensor->kernel_tracking)
 		input_mt_assign_slots(sensor->input,
 				      sensor->tracking_slots,
@@ -278,9 +309,22 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 		}
 	}
 
-	if (f12->data1)
+	if (f12->data1) {
+		u32 data1_bytes = valid_bytes > f12->data1_offset ?
+			min_t(u32, valid_bytes - f12->data1_offset,
+			      f12->data1->reg_size) : 0;
+		u32 objects = min(f12->data1->num_subpackets,
+				  valid_bytes / F12_DATA1_BYTES_PER_OBJ);
+
+		rmi_dbg(RMI_DEBUG_2D_SENSOR, &fn->dev,
+			"%s: objects=%u valid_bytes=%u data1=(%*ph)\n",
+			__func__, objects, valid_bytes,
+			(int)min_t(u32, data1_bytes, 64),
+			data1_bytes ? &sensor->data_pkt[f12->data1_offset] :
+				      sensor->data_pkt);
 		rmi_f12_process_objects(f12, &sensor->data_pkt[f12->data1_offset],
 					valid_bytes);
+	}
 
 	input_mt_sync_frame(sensor->input);
 
@@ -296,10 +340,15 @@ static int rmi_f12_update_dribble(struct rmi_function *fn, struct f12_data *f12)
 	u32 control_size;
 	int error;
 	u8 buf[3];
+	u8 old_val;
 
 	item = rmi_get_register_desc_item(&f12->control_reg_desc, 20);
-	if (!item)
+	if (!item) {
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: Control 20 (EnableDribble) not present in control_reg_desc\n",
+			__func__);
 		return 0;
+	}
 
 	control_offset = rmi_register_desc_calc_reg_offset(&f12->control_reg_desc, 20);
 
@@ -319,6 +368,8 @@ static int rmi_f12_update_dribble(struct rmi_function *fn, struct f12_data *f12)
 	if (rmi_register_desc_has_subpacket(item, 0))
 		subpacket_offset += 1;
 
+	old_val = buf[subpacket_offset];
+
 	switch (f12->sensor.dribble) {
 	case RMI_REG_STATE_OFF:
 		buf[subpacket_offset] &= ~BIT(2);
@@ -331,6 +382,11 @@ static int rmi_f12_update_dribble(struct rmi_function *fn, struct f12_data *f12)
 		break;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: Control 20 present (offset=%u size=%u subpacket_offset=%u): dribble=%d byte %#04x -> %#04x\n",
+		__func__, control_offset, control_size, subpacket_offset,
+		f12->sensor.dribble, old_val, buf[subpacket_offset]);
+
 	error = rmi_write_block(rmi_dev, fn->fd.control_base_addr + control_offset,
 				buf, control_size);
 	if (error)
@@ -529,6 +585,25 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		data_offset += item->reg_size;
 	}
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: has_dribble=%d dribble=%d nbr_fingers=%u pkt_size=%u attn_size=%u max_x=%u max_y=%u x_mm=%u y_mm=%u sensor_type=%d\n",
+		__func__, f12->has_dribble, sensor->dribble, sensor->nbr_fingers,
+		sensor->pkt_size, sensor->attn_size, sensor->max_x, sensor->max_y,
+		sensor->x_mm, sensor->y_mm, sensor->sensor_type);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: data1=%d/%u data5=%d/%u data6=%d/%u data9=%d/%u data15=%d/%u\n",
+		__func__,
+		f12->data1 ? f12->data1_offset : -1,
+		f12->data1 ? f12->data1->reg_size : 0U,
+		f12->data5 ? f12->data5_offset : -1,
+		f12->data5 ? f12->data5->reg_size : 0U,
+		f12->data6 ? f12->data6_offset : -1,
+		f12->data6 ? f12->data6->reg_size : 0U,
+		f12->data9 ? f12->data9_offset : -1,
+		f12->data9 ? f12->data9->reg_size : 0U,
+		f12->data15 ? f12->data15_offset : -1,
+		f12->data15 ? f12->data15->reg_size : 0U);
+
 	/* allocate the in-kernel tracking buffers */
 	sensor->tracking_pos = devm_kcalloc(&fn->dev, sensor->nbr_fingers,
 					    sizeof(*sensor->tracking_pos),
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index b2155c8e20e7..a2f95603aeaf 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -109,10 +109,13 @@ static void rmi_f30_report_button(struct rmi_function *fn,
 	if (f30->trackstick_buttons &&
 	    button >= TRACKSTICK_RANGE_START &&
 	    button <= TRACKSTICK_RANGE_END) {
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: forward trackstick button %u key (0x%04x) value (0x%02x)\n",
+			__func__, button, key_code, key_down);
 		rmi_f03_overwrite_button(f30->f03, key_code, key_down);
 	} else {
 		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
-			"%s: call input report key (0x%04x) value (0x%02x)",
+			"%s: call input report key (0x%04x) value (0x%02x)\n",
 			__func__, key_code, key_down);
 
 		input_report_key(f30->input, key_code, key_down);
@@ -150,6 +153,11 @@ static irqreturn_t rmi_f30_attention(int irq, void *ctx)
 	}
 
 	if (f30->has_gpio) {
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: data_regs (%u bytes): %*ph\n",
+			__func__, f30->register_count,
+			f30->register_count, f30->data_regs);
+
 		for (i = 0; i < f30->gpioled_count; i++)
 			if (f30->gpioled_key_map[i] != KEY_RESERVED)
 				rmi_f30_report_button(fn, f30, i);
@@ -248,10 +256,16 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
 		if (pdata->gpio_data.trackstick_buttons &&
 		    i >= TRACKSTICK_RANGE_START && i < TRACKSTICK_RANGE_END) {
 			f30->gpioled_key_map[i] = trackstick_button++;
+			rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+				"%s: gpio %d -> trackstick button %#04x\n",
+				__func__, i, f30->gpioled_key_map[i]);
 		} else if (!pdata->gpio_data.buttonpad || !button_mapped) {
 			f30->gpioled_key_map[i] = button;
 			input_set_capability(input, EV_KEY, button++);
 			button_mapped = true;
+			rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+				"%s: gpio %d -> input key %#04x\n",
+				__func__, i, f30->gpioled_key_map[i]);
 		}
 	}
 
@@ -267,6 +281,12 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
 	if (pdata->gpio_data.buttonpad || (button - BTN_LEFT == 1))
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: mapped %u buttons, buttonpad=%d (pdata=%d)\n",
+		__func__, button - BTN_LEFT,
+		test_bit(INPUT_PROP_BUTTONPAD, input->propbit),
+		pdata->gpio_data.buttonpad);
+
 	return 0;
 }
 
@@ -295,6 +315,12 @@ static int rmi_f30_initialize(struct rmi_function *fn, struct f30_data *f30)
 
 	f30->register_count = DIV_ROUND_UP(f30->gpioled_count, 8);
 
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"%s: query=[%*ph] has_gpio=%d has_led=%d has_mappable_buttons=%d has_mech_mouse_btns=%d gpioled_count=%u register_count=%u\n",
+		__func__, RMI_F30_QUERY_SIZE, buf, f30->has_gpio, f30->has_led,
+		f30->has_mappable_buttons, f30->has_mech_mouse_btns,
+		f30->gpioled_count, f30->register_count);
+
 	if (f30->has_gpio && f30->has_led)
 		rmi_f30_set_ctrl_data(&f30->ctrl[0], &control_address,
 				      f30->register_count, &ctrl_reg);
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..c96acc85f26f 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -47,7 +47,8 @@ static int rmi_smb_get_version(struct rmi_smb_xport *rmi_smb)
 	/* Check if for SMBus new version device by reading version byte. */
 	retval = i2c_smbus_read_byte_data(client, SMB_PROTOCOL_VERSION_ADDRESS);
 	if (retval < 0) {
-		dev_err(&client->dev, "failed to get SMBus version number!\n");
+		dev_err(&client->dev,
+			"failed to get SMBus version number: %d\n", retval);
 		return retval;
 	}
 
@@ -92,10 +93,19 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
 
 		if (le16_to_cpu(entry->rmiaddr) == rmiaddr) {
 			if (isread) {
-				if (entry->readcount == bytecount)
+				if (entry->readcount == bytecount) {
+					rmi_dbg(RMI_DEBUG_XPORT,
+						&rmi_smb->client->dev,
+						"reusing slot %d for read rmiaddr %#06x len %d\n",
+						i, rmiaddr, bytecount);
 					goto exit;
+				}
 			} else {
 				if (entry->flags & RMI_SMB2_MAP_FLAGS_WE) {
+					rmi_dbg(RMI_DEBUG_XPORT,
+						&rmi_smb->client->dev,
+						"reusing slot %d for write rmiaddr %#06x len %d\n",
+						i, rmiaddr, bytecount);
 					goto exit;
 				}
 			}
@@ -112,6 +122,10 @@ static int rmi_smb_get_command_code(struct rmi_transport_dev *xport,
 	new_map.flags = !isread ? RMI_SMB2_MAP_FLAGS_WE : 0;
 
 	retval = smb_block_write(xport, i + 0x80, &new_map, sizeof(new_map));
+	rmi_dbg(RMI_DEBUG_XPORT, &rmi_smb->client->dev,
+		"programmed slot %#04x (cmd %d) for %s rmiaddr %#06x len %d: %d\n",
+		i + 0x80, i, isread ? "read" : "write", rmiaddr, bytecount,
+		retval);
 	if (retval < 0) {
 		/*
 		 * if not written to device mapping table
@@ -177,8 +191,21 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
+	int retval;
+
+	retval = i2c_smbus_read_block_data(client, commandcode, buf);
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	if (retval < 0)
+		rmi_dbg(RMI_DEBUG_XPORT, &client->dev,
+			"failed to read %zu bytes at %#04x: %d\n",
+			len, commandcode, retval);
+	else
+		rmi_dbg(RMI_DEBUG_XPORT, &client->dev,
+			"read %d/%zu bytes at %#04x: (%*ph)\n",
+			retval, len, commandcode,
+			min_t(int, retval, len), buf);
+
+	return retval;
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
@@ -245,7 +272,7 @@ static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 	if (smbus_version < 0)
 		return smbus_version;
 
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d\n",
 		smbus_version);
 
 	if (smbus_version != 2 && smbus_version != 3) {

-- 
Dmitry
