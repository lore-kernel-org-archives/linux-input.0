From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 5/5] HID: sony: Handle multiple touch events input
 record
Date: Wed, 5 Oct 2016 09:29:53 -0600
Message-ID: <03619b65564e2a66b392b048b1bdc519.squirrel@mungewell.org>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
    <1475636338-3779-6-git-send-email-roderick@gaikai.com>
    <20161005083548.GC19261@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:51226 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbcJEPaJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 11:30:09 -0400
In-Reply-To: <20161005083548.GC19261@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, October 5, 2016 2:35 am, Benjamin Tissoires wrote:
> On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:

>> +		/*
>> +		 * The first 7 bits of the first byte is a counter and bit 8 is
>> +		 * a touch indicator that is 0 when pressed and 1 when not
>> +		 * pressed.
>> +		 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
>> +		 * The data for the second touch is in the same format and
>> +		 * immediately follows the data for the first.
>> +		 */
>> +		for (n = 0; n < 2; n++) {
>> +			u16 x, y;
>> +			bool active;
>> +
>> +			x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
>> +			y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
>> +
>> +			active = !(rd[offset] >> 7);
>> +			input_mt_slot(input_dev, n);
>>
>
> Just to be sure, the device reports 2 touches only, and the
> "num_touch_data" chunks are just the history of these 2 touches, the
> last chunk being the last known touches?

FYI - Community knowledge/understanding...
http://www.psdevwiki.com/ps4/DS4-BT#HID_INPUT_reports

Simon

