From: simon@mungewell.org
Subject: Re: [PATCH v2 2/2] HID: sony: Add output events for the multi-touch
 pad on the Dualshock 4.
Date: Mon, 27 Jan 2014 12:47:48 -0500
Message-ID: <ddf2398947f6323430699b45bc509091.squirrel@mungewell.org>
References: <1390835857-4523-1-git-send-email-frank.praznik@oh.rr.com>
    <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:45893 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbaA0Rru (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 12:47:50 -0500
In-Reply-To: <1390835857-4523-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>


> +
> +	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB.
> +	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
> +	 * indicator that is 0 when pressed and 1 when not pressed.
> +	 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
> +	 * The data for the second touch is in the same format and immediatly
> +	 * follows the data for the first.
> +	 */

Hi Frank,
I don't know if it helps multitouch, but there is a second set of data in
the HID stream, that is present when a figure is moving/swiping on the
touchpad. This gives us a 'vector' rather than a 'point'.

I previously attempted to describe the format here:
http://www.spinics.net/lists/linux-input/msg28525.html

Ahead of the 'event counter' is a 'point or vector' byte and what might be
a 'pressure' measurement (couldn't really tell).

Interspersed with the data you mention is a second set of X1/Y1/X2/Y2 
containing the starting position of the swipe/vector. These are
differentiated with '02' (rather than '01') in the 34'th byte.

1 finger swipe left to right
--
# cat /dev/hidraw0 | hexdump -v -e '64/1 "%02x " "\n"' | cut -d ' ' -f
34-52 | grep -e '^02'
02 01 34 93 90 1d 9e bd e0 23 06 34 94 90 1d 9e bd e0 23
02 1f 34 a5 90 1d 9e bd e0 23 22 34 aa 90 1d 9e bd e0 23
02 3c 34 c3 90 1d 9e bd e0 23 41 34 ca 90 1d 9e bd e0 23
02 7c 34 37 c1 1c 9e bd e0 23 81 34 47 c1 1c 9e bd e0 23
02 bd 34 23 e2 1b 9e bd e0 23 c2 34 3a e2 1b 9e bd e0 23
02 d4 34 8e 82 1b 9e bd e0 23 d9 34 ad 72 1b 9e bd e0 23
02 f8 34 3d 23 1b 9e bd e0 23 fb 34 55 13 1b 9e bd e0 23
02 14 34 a5 e3 1a 9e bd e0 23 1a 34 b6 d3 1a 9e bd e0 23
02 2e 34 f3 b3 1a 9e bd e0 23 31 34 01 a4 1a 9e bd e0 23
02 55 34 40 a4 1a 9e bd e0 23 5a 34 47 a4 1a 9e bd e0 23
02 95 34 71 a4 1a 9e bd e0 23 9a 34 73 a4 1a 9e bd e0 23
02 ad 34 78 a4 1a 9e bd e0 23 b2 34 7a a4 1a 9e bd e0 23
      [ data you use....... ]    [ start of swipe....  ]
--

2 finger swipe top to bottom
--
# cat /dev/hidraw0 | hexdump -v -e '64/1 "%02x " "\n"' | cut -d ' ' -f
34-52 | grep -e '^02'
02 26 37 4a b6 04 9e bd e0 23 2b 37 4a c6 04 9e bd e0 23
02 5b 37 43 96 05 38 64 80 0b 60 37 43 d6 05 38 64 80 0b
02 84 37 3f 56 08 38 6c b0 0c 89 37 3f e6 08 38 6e 00 0d
02 a7 37 38 86 0d 38 80 c0 0f ad 37 37 b6 0e 38 85 80 10
02 d0 37 32 b6 16 38 bc d0 16 d5 37 32 a6 17 38 c5 c0 17
02 f4 37 32 16 1b 38 e7 00 1b f9 37 32 86 1b 38 eb 50 1b
02 17 37 32 f6 1c 38 f5 70 1c 1c 37 32 26 1d 38 f6 90 1c
02 40 37 32 36 1e 38 fd 40 1d 44 37 32 56 1e 38 fd 50 1d
02 63 37 32 c6 1e 38 00 91 1d 68 37 32 e6 1e 38 00 a1 1d
02 86 37 32 46 1f 38 03 d1 1d 8b 37 32 56 1f 38 03 e1 1d
02 af 37 32 b6 1f 38 06 11 1e b3 37 32 c6 1f 38 06 11 1e
02 3b 37 32 96 20 38 0b 81 1e 41 37 32 96 20 38 0b 91 1e
02 82 37 32 e6 20 38 0c c1 1e 87 37 32 e6 20 38 0c c1 1e
02 a5 37 32 16 21 38 0c 01 1f aa 37 32 26 21 38 0c 01 1f
--

Also note that there are seperate event counters for 1st and 2nd fingers,
which mean that the 2nd finger can remain pressed whilst the 1st is
pressed/released.
--
# cat /dev/hidraw0 | hexdump -v -e '64/1 "%02x " "\n"' | cut -d ' ' -f
34-52 | grep -e '^02'
02 a6>42<16 b1 19 c1 58 21 15 ab 42 16 b1 19 c1 58 21 15 <- 1st press
02 15 42 26 b1 19 c1 58 21 15 1b 42 27 b1 19 c1 58 21 15
02 50 42 2d b1 19 c1 58 21 15 55 42 2e b1 19 c1 58 21 15
02 b6 42 41 b1 19 c3 e2 c6 12 bb 42 41 b1 19 44 b5 96 14
02 01 42 43 b1 19>44<a4 96 14 06 42 43 b1 19 44 a3 96 14 <- 2nd press
02 1f 42 43 b1 19 44 9d 96 14 24 42 43 b1 19 44 9c 96 14
02 6b 42 44 b1 19 44 8e 96 14 70 42 45 b1 19 44 8d 96 14
02 cf 42 46 b1 19 44 81 c6 13 d4 42 46 b1 19 44 80 c6 13
02 38 42 47 b1 19 44 78 a6 13 3d 42 47 b1 19 44 77 a6 13
02 3a 42 48 b1 19 44 6b 56 13 3f 42 48 b1 19 44 6b 56 13
02 f5 42 48 d1 1a 44 67 f6 12 fa 42 48 11 1b 44 67 e6 12
02 18 42 49 d1 1c 44 67 d6 12 1d 42 4a 41 1d 44 67 d6 12
02 47 42 53 81 21 44 66 c6 12 4c 42 54 41 22 44 66 c6 12
02 70 42 5d 01 28 44 66 b6 12 75 42 5f e1 28 44 66 b6 12
02 99 42 65 e1 2d 44 66 a6 12 9e 42 66 91 2e 44 66 a6 12
02 bd 42 68 61 31 44 65 96 12 c2 42 68 d1 31 44 65 96 12
02 0e>c2<6d d1 34 44 64 86 12 13 c2 6d d1 34 44 64 86 12 <- 1st release
02 26 c2 6d d1 34 44 64 86 12 2b c2 6d d1 34 44 64 86 12
02 68 c2 6d d1 34 44 62 76 12 6d c2 6d d1 34 44 62 76 12
02 07>45<52 71 08 44 62 76 12 0c 45 52 d1 08 44 62 76 12 <- 1st press
02 30 45 56 41 0c 44 62 76 12 34 45 57 d1 0c 44 62 76 12
02 58 45 5a 51 10 44 62 76 12 5d 45 5a d1 10 44 62 76 12
02 7b 45 5c f1 12 44 62 76 12 80 45 5d 51 13 44 62 76 12
02 ce 45 64 71 1a 44 62 76 12 d3 45 65 01 1b 44 62 76 12
02 f1 45 67 91 1d 44 62 66 12 f6 45 68 21 1e 44 62 66 12
02 3d 45 6f e1 22 44 62 66 12 42 45 6f 01 23 44 62 66 12
02 60 45 70 b1 23 44 62 66 12 65 45 70 c1 23 44 62 66 12
02 3a>c5<73 41 25 44 7a 56 12 3d c5 73 41 25 44 7d b6 12 <- 1st release
02 57 c5 73 41 25 44 87 f6 12 5c c5 73 41 25 44 8a 06 13
--

Simon.


