From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH  3/3] hid: Multitouch support for the N-Trig
 touchscreen
Date: Tue, 19 May 2009 16:50:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de>
References: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168427776-378515101-1242744616=:22712"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46838 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbZESOuP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 10:50:15 -0400
In-Reply-To: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Rafi Rubin <rafi@seas.upenn.edu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168427776-378515101-1242744616=:22712
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 19 May 2009, Stéphane Chatty wrote:

> +/*
> +   this driver is aimed at two firmware versions in circulation:
> +    - dual pen/finger single touch
> +    - finger multitouch, pen not working
> +*/

Please use kernel-style comments (i.e. stars on each line).

> +	case 0xff000000:
> +		/* we do not want to map these */

Why?

> +/*
> + * this function is called upon all reports
> + * so that we can filter contact point information,
> + * decide whether we are in multi or single touch mode
> + * and call input_mt_sync after each point if necessary
> + */
> +static int ntrig_event (struct hid_device *hid, struct hid_field *field,
> +		                        struct hid_usage *usage, __s32 value)
> +{
> +	static __s32 x, y, id, w, h;
> +	static char reading_a_point = 0, found_contact_id = 0;
> +	struct input_dev *input = field->hidinput->input;

Why are these variables static? This will break horribly if multiple 
devices are connected to the system, right?

> +		default:
> +                	hidinput_hid_event(hid, field, usage, value);

Just return 1; here?

> +		}
> +	}
> +        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
> +                hid->hiddev_hid_event(hid, field, usage, value);
> +
> +	return 1;

And return 0; here and let the HID core do all the rest (passing to 
hidinput and hiddev, etc) if necessary?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--168427776-378515101-1242744616=:22712--
