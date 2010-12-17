From: Andy Ross <andy@plausible.org>
Subject: Re: [PATCH] WeTab device ID
Date: Fri, 17 Dec 2010 13:21:07 -0800
Message-ID: <4D0BD443.1070803@plausible.org>
References: <4D0AA66F.6080506@plausible.org> <20101217120322.GA3873@polaris>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101217120322.GA3873@polaris>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/17/2010 04:03 AM, Henrik Rydberg wrote:
> Thanks for the patch. Does the one below work for you?

Looks like this is against more recent changes than I see in the "hid"
branch of input-mt on kernel.org.  I don't see a
"...EGALAX_MULTITOUCH3" defined there.  Maybe you missed a push?  So
not tested as-is, but certainly looks correct by inspection.

Andy
