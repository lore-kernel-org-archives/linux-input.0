From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v2] hid: enable hid device to suspend/resume asynchronously
Date: Mon, 23 Nov 2015 14:03:33 +0800
Message-ID: <5652AC35.5030302@linux.intel.com>
References: <560392E7.1030207@linux.intel.com> <5649F3A3.8080007@linux.intel.com> <alpine.LNX.2.00.1511161624360.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44161 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbbKWGDg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 01:03:36 -0500
In-Reply-To: <alpine.LNX.2.00.1511161624360.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 11/16/2015 11:26 PM, Jiri Kosina wrote:
> On Mon, 16 Nov 2015, Fu, Zhonghui wrote:
>
>> Hi Jiri,
>>
>> Any comments about this patch?
>>
>> After enabling the HID devices suspend/resume asynchronously on ASUS 
>> T100TA(Baytrail-T platform), the system suspend-to-idle/resume time is 
>> reduced about 20ms. Although this improvement is not very significant. 
>> But, if the suspend/resume operation of HID devices is very 
>> time-consuming on some other platforms, this patch can improve 
>> significantly system suspend/resume speed on these platforms.
> Hi,
>
> I don't think the question I've raised at
>
> 	http://lkml.kernel.org/r/alpine.LNX.2.00.1509251404130.30132@pobox.suse.cz
>
> has ever been answered or at least discussed ... ?
Sorry for missing this mail.

At present, the file(/sys/.../power/async) can be used to enable one device suspend/resume asynchronously.  My patch only changes the default value of this file from "disabled" to "enabled".
The sole difference of asynchronous suspend/resume mode is that the suspend/resume operation of one device is carried out in a separate kernel thread, and PM core ensures all related dependency. I have verified this patch on some platforms, such as ASUS T100TA. Actually, many other devices have used this feature for a long time.


Thanks,
Zhonghui
>

