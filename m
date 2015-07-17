From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: Connecting input driver to underlying uart
Date: Fri, 17 Jul 2015 16:00:16 -0700
Message-ID: <1466420.W6prjcqLLf@jclayton-pc>
References: <359253492.mQaq5M2qFo@jclayton-pc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart5577802.CnhbakN0D1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34836 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbGQXAU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 19:00:20 -0400
Received: by pdrg1 with SMTP id g1so68278558pdr.2
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 16:00:19 -0700 (PDT)
In-Reply-To: <359253492.mQaq5M2qFo@jclayton-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

This is a multi-part message in MIME format.

--nextPart5577802.CnhbakN0D1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, July 15, 2015 11:22:06 AM you wrote:
> Hi list,
> I'm starting work on an input driver.
> the device is connected to an RS232 uart in my freescale imx6q arm system, 
> which has 2 serial ports, one of which is a console
> 
> It is not anything like a ps2/at device.
> How can I get it to take over the uart device? A devicetree entry?
> 
> I do not understand serio probing, and don't understand if I should use serio 
> for a non ps2 compatible device.
> 
> Any pointers would be helpful.
> 
> The input device documentation is great if I can just figure out how to 
> connect it to my hardware.
> 
> 
I went ahead and converted (parts of) the existing userspace driver. 
Clearly I am missing something. My driver is registered with serio, but serio is not associated with any devices.
I turned on the SERIO_SERPORT...
/sys/bus/serio/devices/ is empty.
I would like it to bind my driver to /dev/ttymxc1 (uart 2 on this  system), or its underlying uart.

-- 
~Joshua Clayton
--nextPart5577802.CnhbakN0D1
Content-Disposition: attachment; filename="evifpanel.c"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-csrc; charset="UTF-8"; name="evifpanel.c"

#include <linux/input.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/serio.h>
#include <linux/slab.h>

#include <asm/io.h>

#define DRIVER_DESC "Uniwest EVI Frontpanel input driver"

struct fpanel_state {
	int16_t h_value;
	int16_t v_value;
	unsigned char in[8];
	unsigned char led[2];
};

struct evifpanel {
	struct input_dev *dev;
	struct serio *serio;
	unsigned char version[4];
	struct fpanel_state cur;
	struct fpanel_state old;
	unsigned int bytes;
	char name[64];
	char phys[32];
};

struct panel_event {
	uint32_t first;
	union {
		uint32_t raw_val;
		struct {
			int16_t second;
			int16_t third;
		};
	};
};

struct key_map {
	char *name;
	unsigned int code;
	unsigned int byte;
	unsigned int offset;
};

static struct key_map btns[] = {
	{ "F1", KEY_F1, 6, 0 },
	{ "Display", KEY_D, 6, 1 },
	{ "Null", KEY_N, 7, 0 },
	{ "Clear", KEY_BACKSPACE, 7, 1 },
	{ "Enter", KEY_ENTER, 7, 2 },
	{ "Cancel", KEY_ESC, 7, 3 },
	{ "F4", KEY_F4, 7, 4 },
	{ "F3", KEY_F3, 7, 5 },
	{ "F2", KEY_F2, 7, 6 },
	{ },
};

static struct attribute *attrs[] = {
	 NULL,
};

static struct bin_attribute *bin_attrs[] = {
	NULL,
};

struct attribute_group fpanel_attrs = {
	.attrs = attrs,
	.bin_attrs = bin_attrs,
};

/**
 * @brief display horizontal slider positions for testing hardware
 * For each pin, display a '.' for off, or a '-' for on
 */
static void fp_print_h_sliders(struct evifpanel *fp, unsigned char *in)
{
	char h_output[13];

	/* horizontal slider */
	h_output[0] = '-' + !(in[3] & '\x10');
	h_output[1] = '-' + !(in[3] & '\x01');
	h_output[2] = '-' + !(in[4] & '\x40');
	h_output[3] = '-' + !(in[4] & '\x20');
	h_output[4] = '-' + !(in[4] & '\x10');
	h_output[5] = '-' + !(in[4] & '\x08');
	h_output[6] = '-' + !(in[4] & '\x04');
	h_output[7] = '-' + !(in[4] & '\x02');
	h_output[8] = '-' + !(in[4] & '\x01');
	h_output[9] = '-' + !(in[5] & '\x40');
	h_output[10] = '-' + !(in[5] & '\x20');
	h_output[11] = '-' + !(in[3] & '\x08');
	h_output[12] = '\0';

	dev_dbg(&fp->dev->dev, "horizontal slider array: %s\n", h_output);
}

/**
 * @brief display horizontal slider positions for testing hardware
 * For each pin, display a '.' for off, or a '-' for on
 */
static void fp_print_v_sliders(struct evifpanel *fp, unsigned char *in)
{
	char v_output[13];

	v_output[0] = '-' + !(in[3] & '\x02');
	v_output[1] = '-' + !(in[5] & '\x10');
	v_output[2] = '-' + !(in[5] & '\x08');
	v_output[3] = '-' + !(in[5] & '\x04');
	v_output[4] = '-' + !(in[5] & '\x02');
	v_output[5] = '-' + !(in[5] & '\x01');
	v_output[6] = '-' + !(in[6] & '\x40');
	v_output[7] = '-' + !(in[6] & '\x20');
	v_output[8] = '-' + !(in[6] & '\x10');
	v_output[9] = '-' + !(in[6] & '\x08');
	v_output[10] = '-' + !(in[6] & '\x04');
	v_output[11] = '-' + !(in[3] & '\x04');
	v_output[12] = '\0';

	dev_dbg(&fp->dev->dev, "vertical slider array: %s\n", v_output);
}

/**
 * @brief calculate horizontal and vertical sliders and send the event
 */
static void calc_slidervals(struct evifpanel *fp)
{
	uint16_t temp;
	int lo_pins, hi_pins;

	/* horizontal slider */
	temp = 0;
	lo_pins = 0;
	hi_pins = 0;
	if (fp->cur.in[3] & '\x10') {
		lo_pins++;
		temp += 0;
	}
	if (fp->cur.in[3] & '\x01') {
		lo_pins++;
		temp += 1;
	}
	if (fp->cur.in[4] & '\x40') {
		lo_pins++;
		temp += 2;
	}
	if (fp->cur.in[4] & '\x20') {
		lo_pins++;
		temp += 3;
	}
	if (fp->cur.in[4] & '\x10') {
		lo_pins++;
		temp += 4;
	}
	if (fp->cur.in[4] & '\x08') {
		lo_pins++;
		temp += 5;
	}
	if (fp->cur.in[4] & '\x04') {
		hi_pins++;
		temp += 6;
	}
	if (fp->cur.in[4] & '\x02') {
		hi_pins++;
		temp += 7;
	}
	if (fp->cur.in[4] & '\x01') {
		hi_pins++;
		temp += 8;
	}
	if (fp->cur.in[5] & '\x40') {
		hi_pins++;
		temp += 9;
	}
	if (fp->cur.in[5] & '\x20') {
		hi_pins++;
		temp += 10;
	}
	if (fp->cur.in[3] & '\x08') {
		hi_pins++;
		temp += 11;
	}
	fp->old.h_value = fp->cur.h_value;
	if (lo_pins && !hi_pins) {
		fp->cur.h_value = (temp * 0xffff / (11 * lo_pins)) - 0x8000;
	} else if (hi_pins && !lo_pins) {
		fp->cur.h_value = (temp * 0xffff / (11 * hi_pins)) - 0x8000;
	} else {
		fp->cur.h_value = 0;
	}
	if (fp->old.h_value != fp->cur.h_value) {
		struct panel_event evt;

		fp_print_h_sliders(fp, fp->cur.in);
		evt.first = 1;
		evt.second = 0;
		evt.third = fp->cur.h_value;
		dev_dbg(&fp->dev->dev, "sending %#.8x %#.8x horizontal value %d\n",
			evt.first, evt.raw_val, fp->cur.h_value);
/* if (event_fd >= 0) { */
/* bytes = write(event_fd, &evt, sizeof(struct panel_event)); */
/* if (bytes != sizeof(struct panel_event)) { */
/* dev_err(&fp->dev->dev, "Failed to send slider event %#.8x %#.8x: %s\n", */
/* evt.first, evt.raw_val, strerror(errno)); */
/* } */
/* } */
	}

	/*vertical slider */
	temp = 0;
	lo_pins = 0;
	hi_pins = 0;
	if (fp->cur.in[3] & '\x02') {
		lo_pins++;
		temp += 11;
	}
	if (fp->cur.in[5] & '\x10') {
		lo_pins++;
		temp += 10;
	}
	if (fp->cur.in[5] & '\x08') {
		lo_pins++;
		temp += 9;
	}
	if (fp->cur.in[5] & '\x04') {
		lo_pins++;
		temp += 8;
	}
	if (fp->cur.in[5] & '\x02') {
		lo_pins++;
		temp += 7;
	}
	if (fp->cur.in[5] & '\x01') {
		lo_pins++;
		temp += 6;
	}
	if (fp->cur.in[6] & '\x40') {
		hi_pins++;
		temp += 5;
	}
	if (fp->cur.in[6] & '\x20') {
		hi_pins++;
		temp += 4;
	}
	if (fp->cur.in[6] & '\x10') {
		hi_pins++;
		temp += 3;
	}
	if (fp->cur.in[6] & '\x08') {
		hi_pins++;
		temp += 2;
	}
	if (fp->cur.in[6] & '\x04') {
		hi_pins++;
		temp += 1;
	}
	if (fp->cur.in[3] & '\x04') {
		hi_pins++;
		temp += 0;
	}
	fp->old.v_value = fp->cur.v_value;
	if (lo_pins && !hi_pins) {
		fp->cur.v_value = (temp * 0xffff / (11 * lo_pins)) - 0x8000;
	} else if (hi_pins && !lo_pins) {
		fp->cur.v_value = (temp * 0xffff / (11 * hi_pins)) - 0x8000;
	} else {
		fp->cur.v_value = 0;
	}
	if (fp->old.v_value != fp->cur.v_value) {
		struct panel_event evt;

		fp_print_v_sliders(fp, fp->cur.in);
		evt.first = 2;
		evt.second = 0;
		evt.third = fp->cur.v_value;
		dev_dbg(&fp->dev->dev, "sending %#.8x %#.8x vertical value %d\n",
			evt.first, evt.raw_val, fp->cur.v_value);
/* if (event_fd >= 0) { */
/* bytes = write(event_fd, &evt, sizeof(struct panel_event)); */
/* if (bytes != sizeof(struct panel_event)) { */
/* dev_err(&fp->dev->dev, "Failed to send slider event %#.8x %#.8x: %s\n", */
/* evt.first, evt.raw_val, strerror(errno)); */
/* } */
/* } */
	}
}

/**
 * @brief check buttons against a range of bits in a byte
 */
static void fp_check_btns(struct evifpanel *fp, struct key_map *key)
{
	while (key->name) {
		unsigned int mask = 1 << key->offset;
		unsigned int changed = (fp->old.in[key->byte] ^
			fp->cur.in[key->byte]) & mask;
		unsigned int value = fp->cur.in[key->byte] & mask;

		if (changed) {
			input_report_key(fp->dev, key->code, value);
			dev_dbg(&fp->dev->dev, "%s %d\n", key->name, !!(value));
		}
		key++;
	}
}

/**
 * @brief check the led status bytes coming from the fp
 */
static void fp_check_leds(struct evifpanel *fp)
{
	memcpy(fp->old.led, fp->cur.led, 2);
	memcpy(fp->cur.led, fp->cur.in + 6, 2);
	dev_dbg(&fp->dev->dev, "Received led status 0x%2.2X%2.2X\n",
			fp->cur.in[6], fp->cur.in[7]);
}

/**
 * @brief save the version bytes coming from the fp in an ascii file
 */
static void fp_store_version(struct evifpanel *fp)
{
	memcpy(fp->version, fp->cur.in + 4, 4);
	dev_info(&fp->dev->dev, "CPLD Version: %3.3u.%3.3u.%3.3u.%3.3u\n",
				fp->version[0], fp->version[1],
				fp->version[2], fp->version[3]);
}

/**
 * @brief request version info from the fp
 */
static void fp_request_version(struct evifpanel *fp)
{
	serio_write(fp->serio, '\xC0');
	serio_write(fp->serio, '\x00');
	serio_write(fp->serio, '\x00');
	serio_write(fp->serio, '\x09');
	serio_write(fp->serio, '\x00');
	serio_write(fp->serio, '\x01');
	serio_write(fp->serio, '\x00');
	serio_write(fp->serio, '\x00');
}

/**
 * read a command from the input_fd pipe and send it to the fp
 *
static int input_read(int read_fd, struct evifpanel *fp) {
	char buf[4] = {'\0', '\0', '\0', '\0'};
	ssize_t bytes;
	bytes = read(read_fd, buf, 3);
	if (bytes != 3) {
		return errno;
	}
	if (!strncmp("LED", buf, 3)) {
		char send_buf[8] = { '\xC0', '\x00', '\x00', '\x09', '\x00', '\x02',
			fp->cur.led[0], fp->cur.led[1]};
		bytes = read(read_fd, buf, 3);
		char enable = buf[2] - '0';
		char change_bit;
		switch(buf[0]) {
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
			change_bit = 1 << (buf[0] - '1');
			if (enable) {
				send_buf[7] |= change_bit;
			} else {
				send_buf[7] &= ~change_bit;
			}
			break;
		case '8':
		case '9':
			change_bit = 1 << (buf[0] - '8');
			if (enable) {
				send_buf[6] |= change_bit;
			} else {
				send_buf[6] &= ~change_bit;
			}
			break;
		default:
			buf[3] = '\0';
			dev_err(&fp->dev->dev, "Bad input received: LED%s\n", buf);
			return -1;
		}
//		bytes = write(fps->ser->fd, send_buf, 8);
//		if (bytes != 8) {
//			dev_err(&fp->dev->dev, "Failed initial write to fp: %s\n", strerror(errno));
//			return errno;
//		}
	}
	return 0;
}
*/

/**
 * send zero or more events on event_fd  based on the state of the fp
 */
static int fp_process_output(struct evifpanel *fp)
{
	dev_dbg(&fp->dev->dev, "Read %llX\n", *(u64 *)(fp->cur.in));
	switch (fp->cur.in[1]) {
	case '\x03':
		fp_check_btns(fp, btns);
		calc_slidervals(fp);
		memcpy(fp->old.in, fp->cur.in, 8);
		break;
	case '\x09':
		if (fp->cur.in[4] || fp->cur.in[5]) {
			fp_store_version(fp);
		} else {
			fp_check_leds(fp);
		}
		break;
	default:
		dev_err(&fp->dev->dev, "Bad cmd id %X in sequence %llX\n",
				fp->cur.in[1], *(u64 *)(fp->cur.in));

		return -EIO;
	}
	return 0;
}

static void fp_add_byte(struct evifpanel *fp, unsigned char c)
{
	if (c != '\xC0' && !fp->bytes) {
		dev_err(&fp->dev->dev, "drop %X. looking for check byte\n", c);
		return;
	}

	if (c == '\xC0' && fp->bytes) {
		/* msg check byte should not be found in the middle of a set */
		dev_warn(&fp->dev->dev, "discarding %d bytes from %llX\n",
			 fp->bytes, *(u64 *)(fp->cur.in));
		fp->bytes = 0;
	}

	fp->cur.in[fp->bytes] = c;
	++fp->bytes;
	if (fp->bytes == 8) {
		fp_process_output(fp);
		fp->bytes = 0;
	}
}


static irqreturn_t fp_interrupt(struct serio *serio, unsigned char data,
		unsigned int flags)
{
	struct evifpanel *fp = serio_get_drvdata(serio);

	fp_add_byte(fp, data);

	return IRQ_HANDLED;
}

static void fp_set_device_attrs(struct evifpanel *fp)
{
	snprintf(fp->name, sizeof(fp->name),
			"EVI Frontpanel keypad and sliders");
	snprintf(fp->phys, sizeof(fp->phys),
			"%s/input0", fp->serio->phys);

	fp->dev->name = fp->name;
	fp->dev->phys = fp->phys;
	fp->dev->id.bustype = BUS_RS232;
	fp->dev->dev.parent = &fp->serio->dev;

	fp->dev->evbit[0] = BIT_MASK(EV_KEY);
	__set_bit(KEY_D, fp->dev->keybit);
	__set_bit(KEY_N, fp->dev->keybit);
	__set_bit(KEY_BACKSPACE, fp->dev->keybit);
	__set_bit(KEY_ENTER, fp->dev->keybit);
	__set_bit(KEY_F1, fp->dev->keybit);
	__set_bit(KEY_F2, fp->dev->keybit);
	__set_bit(KEY_F3, fp->dev->keybit);
	__set_bit(KEY_F4, fp->dev->keybit);
	__set_bit(KEY_ESC, fp->dev->keybit);

/* fp->dev->keybit[BIT_WORD(BTN_0)] = BIT_MASK(BTN_0); */
}

static int fp_connect(struct serio *serio, struct serio_driver *drv)
{
	struct evifpanel *fp;
	struct input_dev *input_dev;
	int error = -ENOMEM;

	pr_info("fp_connect start\n");
	fp = kzalloc(sizeof(*fp), GFP_KERNEL);

	input_dev = input_allocate_device();
	if (!input_dev || !fp) {
		pr_err("evifpanel: failed to get memory\n");
		goto fail1;
	}

	fp->dev = input_dev;

	serio_set_drvdata(serio, fp);

	error = serio_open(serio, drv);
	if (error) {
		pr_err("evifpanel: failed to open serio\n");
		goto fail2;
	}
	fp_request_version(fp);

	error = sysfs_create_group(&serio->dev.kobj, &fpanel_attrs);
	if (error) {
		pr_err("evifpanel: failed to create sysfs group\n");
		goto fail3;
	}

	fp_set_device_attrs(fp);

	error = input_register_device(fp->dev);
	if (error) {
		pr_err("evifpanel: failed to register input device\n");
		goto fail4;
	}

	return 0;

fail4:
	sysfs_remove_group(&serio->dev.kobj, &fpanel_attrs);
fail3:
	serio_close(serio);
fail2:
	serio_set_drvdata(serio, NULL);
fail1:
	input_free_device(input_dev);
	kfree(fp);
	pr_err("fp_connect: FAILED\n");

	return error;
}

static void fp_disconnect(struct serio *serio)
{
	struct evifpanel *fp = serio_get_drvdata(serio);

	input_unregister_device(fp->dev);
	serio_close(serio);
	serio_set_drvdata(serio, NULL);
	kfree(fp);
};

static struct serio_device_id fp_ids[] = {
	{
		.type  = SERIO_RS232,
		.proto = SERIO_ANY,
		.id    = SERIO_ANY,
		.extra = SERIO_ANY,
	},
	{ 0 }
};

static const struct of_device_id my_of_ids[] = {
	{ .compatible = "uniwest,evi-fpanel" },
	{},
};

static struct serio_driver fp_drv = {
	.driver = {
		.name = "evifpanel",
		.of_match_table = my_of_ids,
	},
	.description = DRIVER_DESC,
	.id_table    = fp_ids,
	.connect     = fp_connect,
	.interrupt   = fp_interrupt,
	.disconnect  = fp_disconnect,
};

module_serio_driver(fp_drv);
MODULE_AUTHOR("Joshua Clayton <joshua.clayton@uniwest.com>");
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_LICENSE("GPL");

--nextPart5577802.CnhbakN0D1--

