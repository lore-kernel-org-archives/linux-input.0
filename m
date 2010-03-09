From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 1/1] hid-magicmouse: Fix oops after device removal.
Date: Tue, 09 Mar 2010 06:32:30 -0500
Message-ID: <87ocix20j5.fsf@troilus.org>
References: <87aaui2usx.fsf@troilus.org>
	<20100309074820.GD17288@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55977 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754760Ab0CILcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 06:32:33 -0500
Received: by qw-out-2122.google.com with SMTP id 9so779973qwb.27
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 03:32:32 -0800 (PST)
In-Reply-To: <20100309074820.GD17288@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Mon, 8 Mar 2010 23:48:20 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

Dmitry Torokhov writes:

>>  static void magicmouse_remove(struct hid_device *hdev)
>>  {
>> +	struct magicmouse_sc *msc;
>
> Blank lines between variable definitions and code are always
> appreciated. but also coudl be written as:
>
> 	struct magicmouse_sc *msc = hid_get_drvdata(dev);
>
>> +	msc = hid_get_drvdata(hdev);
>>  	hid_hw_stop(hdev);
>> +	input_unregister_device(msc->input);
>>  	kfree(hid_get_drvdata(hdev));
>
> You have msc already sho that should be 'kfree(msc);'.

I'll fix both of these and resubmit.  Thanks for the review.

Michael


