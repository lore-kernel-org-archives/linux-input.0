From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/7] HID: wiimote: Simplify synchronization
Date: Sun, 14 Aug 2011 13:15:54 +0200
Message-ID: <CANq1E4Qwf1GZV3RZVb3_2pZq71-xmY2mYs-RBvk17sB9ZfW8jw@mail.gmail.com>
References: <1313242155-3620-1-git-send-email-dh.herrmann@googlemail.com>
	<1313242155-3620-2-git-send-email-dh.herrmann@googlemail.com>
	<201108141255.36385.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49916 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab1HNLPz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2011 07:15:55 -0400
Received: by vxi9 with SMTP id 9so3313667vxi.19
        for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 04:15:54 -0700 (PDT)
In-Reply-To: <201108141255.36385.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, jkosina@suse.cz

On Sun, Aug 14, 2011 at 12:55 PM, Oliver Neukum <oliver@neukum.org> wro=
te:
> Am Samstag, 13. August 2011, 15:29:09 schrieb David Herrmann:
>> @@ -362,6 +343,15 @@ static struct wiimote_data *wiimote_create(stru=
ct hid_device *hdev)
>>
>> =A0static void wiimote_destroy(struct wiimote_data *wdata)
>> =A0{
>> + =A0 =A0 =A0 device_remove_file(&wdata->hdev->dev, &dev_attr_led1);
>> + =A0 =A0 =A0 device_remove_file(&wdata->hdev->dev, &dev_attr_led2);
>> + =A0 =A0 =A0 device_remove_file(&wdata->hdev->dev, &dev_attr_led3);
>> + =A0 =A0 =A0 device_remove_file(&wdata->hdev->dev, &dev_attr_led4);
>> +
>> + =A0 =A0 =A0 input_unregister_device(wdata->input);
>> + =A0 =A0 =A0 hid_hw_stop(wdata->hdev);
>> +
>> + =A0 =A0 =A0 cancel_work_sync(&wdata->worker);
>> =A0 =A0 =A0 =A0 kfree(wdata);
>> =A0}
>
> This looks like the work can run on a device whose hardware has alrea=
dy been
> stopped. Is this safe?

With bthid this is safe, although not very nice. usbhid does not allow
this so I will swap the cancel_work_sync() and hid_hw_stop() calls so
I do not depend on special bthid behaviour.
Nice catch, thanks.

> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
>

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
