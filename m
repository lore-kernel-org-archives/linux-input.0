From: John S Gruber <JohnSGruber@gmail.com>
Subject: [PATCH 0/2] "HID: redragon: Fix modifier keys for Redragon Asura
 Keyboard" causes regression for Acer keyboard
Date: Sat, 28 Jul 2018 15:53:45 -0400
Message-ID: <CAPotdmS6dv0YkqX4QBt-DaYsO77Hza2bgMLJuzHi+cjNn27fYw@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Robert Munteanu <rombert@apache.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, JohnSGruber@gmail.com
List-Id: linux-input@vger.kernel.org

Please cc me in any replies.

The Acer branded keyboard that came with my Acer ATC-605-UB11 computer system
fails completely due to:

85455dd906d5 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard.")

That commit was merged to 4.18 on June 8.

The redragon vendor_id device_id combination 0c45:760b is shared by that
keyboard, as well as many others, it appears.
See https://linux-hardware.org/index.php?id=usb:0c45-760b
for other SONiX keyboards that don't appear to be Redragon devices.

First patch:

While the Redragon keyboard uses the second device created and not the first,
the Acer, and perhaps many others, use that first device
(the one with dev->maxapplication==1).

The hid-redragon.c driver should not cause this device to be ignored and
should not interfere with its being cleared up when disconnected.
It appears to me that this problematic change was made late in the
patch's revisions as a clean up.

I recently tried to connect another usb keyboard after the redragon driver
was activated by my Acer keyboard. It is blocked from working too
until the kernel is rebooted without my keyboard being plugged in. I
also understand that the interference with the first device stops
the keyboard LEDs from working correctly.



I'm resending this set as I haven't heard from the hid people in the two
weeks since I first sent this. Before 3.18 is released I believe either
this patch should be quickly finalized and applied, Robert's patch in the
linux-next tree should be applied instead, dc9b8e85ed9, or, as a last option,
the problematic commit should be reverted. I've tested all three
possibilities.

Second Patch:

As there are potentially many different devices being intercepted by the new
hid-redragon driver, and as the bytes x81 x00 are not rare in this context,
I also think it's advisable to improve the verification condition before
performing the report-description patch only meant for the Redragon Asura
Keyboard.



These two patches will follow. The first restores the function of my keyboard
sucessfully.

I don't have the Redragon Asura Keyboard necessary to test the second patch.
Its rdesc data come from Robert as posted to pastebin.

John S Gruber (2):
  HID: redragon: Fix regression in non-Redragon keyboard due to this new
    driver
  HID: redragon Add additional verification to rdesc modification quirk

 drivers/hid/hid-redragon.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
1.9.1
