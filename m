From: Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: [PATCH 2/2] Add driver for mouse logitech M560
Date: Tue, 02 Jun 2015 14:07:51 +0200
Message-ID: <556D9C97.7060100@libero.it>
References: <1432976427-12013-1-git-send-email-kreijack@libero.it> <1432976427-12013-3-git-send-email-kreijack@libero.it> <alpine.LNX.2.00.1506011437270.16120@pobox.suse.cz>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-18.italiaonline.it ([212.48.25.146]:46902 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751949AbbFBMHy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Jun 2015 08:07:54 -0400
In-Reply-To: <alpine.LNX.2.00.1506011437270.16120@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Dario Righelli <drighelli@gmail.com>, linux-input@vger.kernel.org, Goffredo Baroncelli <kreijack@inwind.it>

Hi Jiri,

On 2015-06-01 14:39, Jiri Kosina wrote:

> [ ... snip ... ]
>> +		v = hid_snto32(hidpp_field_extract(hdev, data+3, 0, 12), 12);
>> +		input_report_rel(mydata->input, REL_X, v);
>> +
>> +		v = hid_snto32(hidpp_field_extract(hdev, data+3, 12, 12), 12);
>> +		input_report_rel(mydata->input, REL_Y, v);
> 
> There is no hidpp_field_extract() any more in this version of the 
> patchset.
> 
> I've fixed that up and queued in for-4.2/logitech.
> 
I am embarrassed, you are right, I forgot to add these "last minute" changes in 
the git...

Anyway, thanks for the inclusion

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
