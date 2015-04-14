From: Andreas Fleig <andreasfleig@gmail.com>
Subject: Re: [PATCH v2] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Tue, 14 Apr 2015 11:40:13 +0200
Message-ID: <1429004413.2676.0@smtp.gmail.com>
References: <1428485767.14997.1@smtp.gmail.com>
	<CAN+gG=G3NP-51vQEO5yJ40-c+YXbEdZoWFwVGraUexM1+uZ5-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33218 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbbDNJkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 05:40:15 -0400
Received: by wiax7 with SMTP id x7so84096991wia.0
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 02:40:14 -0700 (PDT)
In-Reply-To: <CAN+gG=G3NP-51vQEO5yJ40-c+YXbEdZoWFwVGraUexM1+uZ5-g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Apr 13, 2015 at 7:23 , Benjamin Tissoires 
<benjamin.tissoires@gmail.com> wrote:
> Are we sure that there is no other integrated mouse than the track 
> point?
> I would not like us to set INPUT_PROP_POINTING_STICK to other input
> devices that should not have them.
> 
> If you are not sure, maybe test with the product ID so that we know
> which ones are enabled/tested.

Thanks! Currently, the driver is only for three devices which all have 
a trackpoint. But since lenovo_input_mapping is also testing for 
product ids, I'll add the same test and send in a v3.

Andreas

