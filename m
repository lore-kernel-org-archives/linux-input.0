From: Wayne Thomas <waynethomas69@gmail.com>
Subject: Re: HID: expand hid-topseed driver to support BTC "Emprex 3009URF III
	Vista MCE Remote"
Date: Wed, 28 Apr 2010 16:54:00 +0200
Message-ID: <m2x3711715e1004280754h35225f9ch75cb0be11ab6b75e@mail.gmail.com>
References: <t2g3711715e1004240718m8aacffc5o68fc9ccd1e66f212@mail.gmail.com>
	 <w2l3711715e1004271145v133cd94ax971aa213eb60cfaa@mail.gmail.com>
	 <alpine.LNX.2.00.1004272242050.9849@pobox.suse.cz>
	 <y2u3711715e1004272206u4700fac7u744b2fb0cf203367@mail.gmail.com>
	 <alpine.LNX.2.00.1004281349130.9849@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1004281349130.9849@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 28, 2010 at 1:51 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 28 Apr 2010, Wayne Thomas wrote:
>
>> >> OK, next attempt...
>> >
>> > The patch is OK, but your mail client whitespace-damaged it. Could=
 you
>> > please fix up your client and resend? (or attach it separately as =
an
>> > attachment, if your client can't be fixed).
>> >
>> > Thanks,
>>
>> I thought it might have; sorry about that.
>> Have attached patch as separate file as a precaution.
>
> Thanks for the patch.
>
> What is the reason for it being backwards-compatible with the older
> topspeed device?
>
> Changes such as
>
> - =A0 =A0 =A0 case 0x048: ts_map_key_clear(KEY_RED); =A0 =A0 =A0 =A0 =
=A0 =A0break;
> + =A0 =A0 =A0 case 0x05b: ts_map_key_clear(KEY_RED); =A0 =A0 =A0 =A0 =
=A0break;
>
> (and no other handling of neither 0x048 nor KEY_RED) make me wonder .=
=2E.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

The TopSeed remote has four keys in particular with two labels on each
of them (but only a single output for each key):

- the button with output 0x047 is coloured Green and has the label 'MUS=
IC'
- the button with output 0x048 is coloured Red and has the label 'DVD/V=
CD'
- the button with output 0x049 is coloured Yellow and has the label 'PI=
CTURE'
- the button with output 0x04a is coloured Blue and has the label 'VIDE=
O'

The BTC remote has four buttons with identical outputs and the same
labels but they are not coloured.  The BTC has seperate coloured
buttons with completely different outputs.

The original writer of hid-topseed chose to use the colour of the
TopSeed buttons for his key maps rather than the labels.  If I did not
change this the BTC would effectively loose four buttons as each
coloured button would have the same keymap as the seperate labelled
button (i.e. Music, DVD/VCD, PICTURE, VIDEO).  To prevent this I
altered the original keymaps of the TopSeed to use the appropriate
label, and added the BTC's coloured keymap as seperate buttons.  (I
hope I made sense).

Every original TopSeed button has been represented in the driver (i.e.
I changed case 0x048 to KEY_CAMERA) and I tidied up the order that
they have appeared.  Below I have re-jigged the relevant part of the
patch to help explain (sorry for the whitespace damage that will no
doubt occur).  There are obviously some unneccessary deletions and
re-insertions, this occured due to me starting from scratch.
Ultimately there are four changes and six new entries.

-        case 0x00d: ts_map_key_clear(KEY_HOME);           break;
+       case 0x00d: ts_map_key_clear(KEY_HOME);         break;
-        case 0x024: ts_map_key_clear(KEY_MENU);           break;
+       case 0x024: ts_map_key_clear(KEY_MENU);         break;
-        case 0x025: ts_map_key_clear(KEY_TV);             break;
+       case 0x025: ts_map_key_clear(KEY_TV);           break;
-        case 0x048: ts_map_key_clear(KEY_RED);            break;
+       case 0x048: ts_map_key_clear(KEY_DVD);          break;
-        case 0x047: ts_map_key_clear(KEY_GREEN);          break;
+       case 0x047: ts_map_key_clear(KEY_MP3);          break;
-        case 0x049: ts_map_key_clear(KEY_YELLOW);         break;
+       case 0x049: ts_map_key_clear(KEY_CAMERA);       break;
-        case 0x04a: ts_map_key_clear(KEY_BLUE);           break;
+       case 0x04a: ts_map_key_clear(KEY_VIDEO);        break;
-        case 0x04b: ts_map_key_clear(KEY_ANGLE);          break;
+       case 0x04b: ts_map_key_clear(KEY_ANGLE);        break;
-        case 0x04c: ts_map_key_clear(KEY_LANGUAGE);       break;
+       case 0x04c: ts_map_key_clear(KEY_LANGUAGE);     break;
-        case 0x04d: ts_map_key_clear(KEY_SUBTITLE);       break;
+       case 0x04d: ts_map_key_clear(KEY_SUBTITLE);     break;
-        case 0x031: ts_map_key_clear(KEY_AUDIO);          break;
+       case 0x031: ts_map_key_clear(KEY_AUDIO);        break;
-        case 0x032: ts_map_key_clear(KEY_TEXT);           break;
+       case 0x032: ts_map_key_clear(KEY_TEXT);         break;
-        case 0x033: ts_map_key_clear(KEY_CHANNEL);        break;
+       case 0x033: ts_map_key_clear(KEY_CHANNEL);      break;
+       case 0x050: ts_map_key_clear(KEY_RADIO);        break;
+       case 0x05b: ts_map_key_clear(KEY_RED);          break;
+       case 0x05c: ts_map_key_clear(KEY_GREEN);        break;
+       case 0x05d: ts_map_key_clear(KEY_YELLOW);       break;
+       case 0x05e: ts_map_key_clear(KEY_BLUE);         break;
+       case 0x05a: ts_map_key_clear(KEY_TEXT);         break;

I hope this has answered your question sufficiently.

Cheers
Wayne
