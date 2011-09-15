From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH] hidraw : free list for all error in hidraw_open
Date: Thu, 15 Sep 2011 16:34:13 +0100
Message-ID: <CAAG0J9-6T6uVS2VSJu--09T32RL3j6XSHZ5mC8gHQ4o+qz2VJA@mail.gmail.com>
References: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f45.google.com ([209.85.212.45]:62425 "EHLO
	mail-vw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934023Ab1IOPeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Sep 2011 11:34:14 -0400
In-Reply-To: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>

On 2 September 2011 06:29, Amit Nagal <helloin.amit@gmail.com> wrote:
> Hi ,
>
> In function hidraw_open (linux-3.0.3/drivers/hid/hidraw.c ) , =A0stru=
ct
> hidraw_list *list should be freed for all error conditions .
> Following is patch enclosed for the same :
>
> Signed-off-by: Amit Nagal <helloin.amit@gmail.com>

Another patch (3a22ebe9cc76acac2511b1d3979a35609924ce42 "HID: hidraw:
fix hidraw_disconnect()", pasted below) tried to fix the same problem,
but introduced a different problem where the device_destroy in
hidraw_disconnect would cause the hidraw to get freed, and then
hidraw_disconnect() would go and reference it then try and free it
again. I believe that patch should now be reverted, as with this patch
the device_destroy will free the list, and won't free the hidraw,
allowing hidraw_disconnect to clean it up itself. Does that sound
correct?

Cheers
James

commit 3a22ebe9cc76acac2511b1d3979a35609924ce42
Author: Stefan Achatz <erazor_de@users.sourceforge.net>
Date:   Sat Jan 29 02:17:30 2011 +0100

    HID: hidraw: fix hidraw_disconnect()

    hidraw_disconnect() first sets an entry in hidraw_table to NULL
    and calls device_destroy() afterwards. The thereby called
    hidraw_release() tries to read this already cleared value resulting
    in never removing any device from the list.
    This got fixed by changing the order of events.

    Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 468e87b..5516ea4 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -428,12 +428,12 @@ void hidraw_disconnect(struct hid_device *hid)

        hidraw->exist =3D 0;

+ device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
+
        mutex_lock(&minors_lock);
        hidraw_table[hidraw->minor] =3D NULL;
        mutex_unlock(&minors_lock);

-   device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
-
        if (hidraw->open) {
                hid_hw_close(hid);
                wake_up_interruptible(&hidraw->wait);



> ---
>
> diff -uprN linux-3.0.3/drivers/hid/hidraw.c.orig
> linux-3.0.3/drivers/hid/hidraw.c
> --- linux-3.0.3/drivers/hid/hidraw.c.orig =A0 =A0 =A0 2011-09-01
> 13:23:19.000000000 -0400
> +++ linux-3.0.3/drivers/hid/hidraw.c =A0 =A02011-09-02 06:25:08.00000=
0000 -0400
> @@ -259,7 +259,6 @@ static int hidraw_open(struct inode *ino
>
> =A0 =A0 =A0 =A0mutex_lock(&minors_lock);
> =A0 =A0 =A0 =A0if (!hidraw_table[minor]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unlock;
> =A0 =A0 =A0 =A0}
> @@ -285,6 +284,8 @@ static int hidraw_open(struct inode *ino
> =A0out_unlock:
> =A0 =A0 =A0 =A0mutex_unlock(&minors_lock);
> =A0out:
> + =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(list);
> =A0 =A0 =A0 =A0return err;
>
> =A0}
>
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
James Hogan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
