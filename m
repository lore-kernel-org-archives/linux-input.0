From: Barton C Massey <bart@cs.pdx.edu>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 26 Apr 2007 11:35:30 -0700
Message-ID: <200704261835.l3QIZU1a017664@wezen.cs.pdx.edu>
References: <20070426000037.GF4831@aehallh.com>
	<20070425200650.GE4831@aehallh.com> <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz> <1176330232.27324.7.camel@johannes.berg> <200704122125.l3CLP9aQ005277@wezen.cs.pdx.edu> <1176446418.7052.54.camel@johannes.berg> <200704252309.l3PN9RUa018798@adara.cs.pdx.edu>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: Your message of "Wed, 25 Apr 2007 20:00:37 EDT."
	<20070426000037.GF4831@aehallh.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-input@vger.kernel.org

In message <20070426000037.GF4831@aehallh.com> you wrote:
> Alright, note that at the moment there is no way to invert it except
> with xmodmap. (Since they get mapped as buttons, you can swap them there
> in a trivial fashion.  If you're already swapping because you're left
> handed, it's even easier.)

The six places that an axis can be flipped are:

   1. By the input driver
   2. By the evdev code
   3. By the X evdev driver
   4. By the xmodmap event mapping
   5. By the toolkit
   6. By the application itself

I've seen all but 3 and 5 in various situations in practice.

Five is particularly troublesome, since it's on a per-app
basis, leading to inconsistent bug reports.  Encourage
people to use GIMP when testing, rather than
Firefox/Iceweasel, as the GIMP seems to consistently get it
right and isn't really subject to toolkit troubles.

Somebody probably needs to write a bunch of code that will
look at layers 2-4 and provide a definitive report of what's
going on.  In my copious spare time...

    Bart Massey
    Assoc. Prof. Computer Science
    Portland State University
    bart@cs.pdx.edu
