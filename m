From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Mon, 6 Nov 2017 09:05:03 +0100
Message-ID: <20171106080503.GB9728@mail.corp.redhat.com>
References: <20171103172947.15156-1-benjamin.tissoires@redhat.com>
 <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jason,

On Nov 03 2017 or thereabouts, Jason Gerecke wrote:
> On November 3, 2017 10:29:47 AM PDT, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >The Dell Canvas exports 2 collections for the Pen part. The only
> >difference between the 2 is that the default one has half the
> >resolution
> >of the second one.
> >
> >The Windows driver switches the tablet into the second mode, so we
> >should
> >behave the same.
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >---
> >
> >Hi,
> >
> >well, this is not the cleanest way of handling this mode set, but it is
> >the
> >less intrusive AFAICT.
> >
> >I was thinking that we might want to add a new field in struct
> >wacom_feature,
> >but then it wouldn't make sense to keep the set mode specifics in
> >_wacom_query_tablet_data().
> >
> >So I am open to any better suggestion, but this one works and the
> >impact on
> >other HID generic tablets is null.
> >
> 
> Hmm. Agreed that this isn't ideal. I'd like to take a look at the descriptor, if you wouldn't mind sharing it. The hardware should be similar to other devices of ours and it might be possible to piggyback on existing code.
>

Sure, here it comes in the hid-replay format (and with a recording
of a single dot from the pen):

Cheers,
Benjamin

---

D: 0
R: 373 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 95 02 75 01 81 02 95 01 75 06 81 03 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0 05 0d 09 02 a1 01 85 02 09 20 a1 00 09 42 09 44 09 45 09 3c 09 5a 09 32 15 00 25 01 75 01 95 06 81 02 95 02 81 03 05 01 09 30 27 8d 74 00 00 47 1a e9 00 00 65 11 55 0d 75 10 95 01 81 02 09 31 27 8f 41 00 00 47 1e 83 00 00 81 02 45 00 65 00 55 00 05 0d 09 30 26 ff 0f 81 02 06 00 ff 09 04 75 08 26 ff 00 46 ff 00 65 11 55 0e 81 02 05 0d 09 3d 75 10 16 d8 dc 26 28 23 36 d8 dc 46 28 23 65 14 81 02 09 3e 81 02 65 00 55 00 15 00 35 00 45 00 c0 09 00 75 08 26 ff 00 b1 12 c0 06 00 ff 09 00 a1 01 85 11 05 0d 09 20 a1 00 09 42 09 44 09 45 09 3c 09 5a 09 32 15 00 25 01 75 01 95 06 81 02 95 02 81 03 05 01 09 30 27 1a e9 00 00 47 1a e9 00 00 6
 5 11 55 0d 75 10 95 01 81 02 09 31 27 1e 83 00 00 47 1e 83 00 00 81 02 45 00 65 00 55 00 05 0d 09 30 26 ff 0f 81 02 06 00 ff 09 04 75 08 26 ff 00 46 ff 00 65 11 55 0e 81 02 05 0d 09 3d 75 10 16 d8 dc 26 28 23 36 d8 dc 46 28 23 65 14 81 02 09 3e 81 02 65 00 55 00 15 00 35 00 45 00 c0 09 00 75 08 26 ff 00 95 03 b1 12 c0 05 01
N: Tablet ISD-V4
P: usb-0000:39:00.0-1.5/input0
I: 3 056a 4200
D: 0
E: 0.000000 13 11 20 8b c8 35 47 00 00 24 00 00 00 00
E: 0.001027 13 11 20 8b c8 35 47 00 00 24 00 00 00 00
E: 0.002817 13 11 20 8b c8 35 47 00 00 22 00 00 00 00
E: 0.009885 13 11 20 8b c8 35 47 00 00 1f 00 00 00 00
E: 0.012881 13 11 20 8b c8 35 47 00 00 1b 00 00 00 00
E: 0.019914 13 11 20 96 c8 25 47 00 00 17 00 00 00 00
E: 0.022898 13 11 20 ac c8 14 47 00 00 12 00 00 00 00
E: 0.029904 13 11 20 f6 c8 c6 46 00 00 0f 00 00 00 00
E: 0.032898 13 11 20 d1 c8 f6 46 00 00 0b 00 00 00 00
E: 0.038908 13 11 21 e2 c8 de 46 21 0b 07 b8 0b d4 fe
E: 0.042902 13 11 21 f3 c8 c7 46 17 0b 04 b8 0b d4 fe
E: 0.048946 13 11 21 f3 c8 c7 46 f3 0a 04 b8 0b d4 fe
E: 0.052928 13 11 21 f3 c8 c7 46 d2 0a 04 b8 0b d4 fe
E: 0.058924 13 11 21 f3 c8 c7 46 a0 0a 02 b8 0b d4 fe
E: 0.062923 13 11 21 f3 c8 c7 46 60 0a 01 b8 0b d4 fe
E: 0.068904 13 11 21 f3 c8 c7 46 1d 0a 00 b8 0b d4 fe
E: 0.072901 13 11 21 f3 c8 c7 46 cd 09 00 b8 0b d4 fe
E: 0.078900 13 11 21 f3 c8 c7 46 8a 09 00 b8 0b d4 fe
E: 0.082900 13 11 21 f3 c8 c7 46 3c 09 00 b8 0b d4 fe
E: 0.088905 13 11 21 f3 c8 c7 46 ae 08 00 b8 0b d4 fe
E: 0.092904 13 11 21 06 c9 c4 46 e2 07 00 b8 0b d4 fe
E: 0.098904 13 11 21 18 c9 bd 46 89 06 00 b8 0b d4 fe
E: 0.102910 13 11 21 24 c9 ad 46 5e 03 00 b8 0b d4 fe
E: 0.108910 13 11 20 24 c9 ad 46 00 00 00 00 00 00 00
E: 0.109899 13 11 20 31 c9 9c 46 00 00 00 00 00 00 00
E: 0.112897 13 11 20 3a c9 8a 46 00 00 01 00 00 00 00
E: 0.118901 13 11 20 44 c9 79 46 00 00 01 00 00 00 00
E: 0.122902 13 11 20 42 c9 69 46 00 00 03 00 00 00 00
E: 0.128926 13 11 20 40 c9 5a 46 00 00 05 00 00 00 00
E: 0.132923 13 11 20 40 c9 5a 46 00 00 09 00 00 00 00
E: 0.138927 13 11 20 30 c9 54 46 00 00 10 00 00 00 00
E: 0.142922 13 11 20 0c c9 4f 46 00 00 1a 00 00 00 00
E: 0.148904 13 11 20 d4 c8 4c 46 00 00 25 00 00 00 00
E: 0.152902 13 11 20 8d c8 4b 46 00 00 32 00 00 00 00
E: 0.158911 13 11 20 36 c8 4b 46 00 00 42 00 00 00 00
E: 0.162897 13 11 20 f0 c7 4b 46 00 00 4a 00 00 00 00
E: 0.168907 13 11 20 b1 c7 4c 46 00 00 53 00 00 00 00
E: 0.172899 13 11 20 75 c7 4d 46 00 00 5c 00 00 00 00
E: 0.178893 13 11 20 3a c7 4f 46 00 00 65 00 00 00 00
E: 0.182887 13 11 20 fc c6 51 46 00 00 6f 00 00 00 00
E: 0.188912 13 11 20 bd c6 52 46 00 00 6f 00 00 00 00
E: 0.191923 13 11 20 81 c6 53 46 00 00 6f 00 00 00 00
E: 0.198924 13 11 20 47 c6 55 46 00 00 6f 00 00 00 00
E: 0.201925 13 11 20 11 c6 56 46 00 00 6f 00 00 00 00
E: 0.208907 13 11 00 11 c6 56 46 00 00 6f 00 00 00 00
 
