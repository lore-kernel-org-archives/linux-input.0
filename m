From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 07/18] HID: wacom: generic: Support and use 'Custom
 HID' mode and usages
Date: Tue, 18 Oct 2016 17:26:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1610181725150.31629@cbobk.fhfr.pm>
References: <20161006212231.31440-1-killertofu@gmail.com> <20161007221653.26941-1-killertofu@gmail.com> <20161007221653.26941-7-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57385 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934255AbcJRP0z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 11:26:55 -0400
In-Reply-To: <20161007221653.26941-7-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 7 Oct 2016, Jason Gerecke wrote:

> @@ -1711,7 +1736,7 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>  
>  
>  	if (usage->usage_index + 1 == field->report_count) {
> -		if (usage->hid == wacom_wac->features.last_slot_field)
> +		if (equivalent_usage == wacom_wac->features.last_slot_field)

What tree is this based on please? In all the codebase I have, 
last_slot_field is a member field of wacom_wac's hid_data, not a member of 
struct wacom_features.

-- 
Jiri Kosina
SUSE Labs

