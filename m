From: Chris Lalancette <clalance@redhat.com>
Subject: Re: [PATCH]: Add command-line option to i8042 to completely disable
 it
Date: Wed, 25 Jul 2007 09:35:22 -0400
Message-ID: <46A7519A.20108@redhat.com>
References: <46A4DFD2.2010501@redhat.com> <20070725000504.f8ce49c1.akpm@linux-foundation.org> <20070725080355.GA14726@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070725080355.GA14726@suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Vojtech Pavlik wrote:
>>
>>That's an unfortunate fix.  Is there really no way in which we
>>can auto-detect such a situation without requiring a manual
>>setting?
> 
> 
> The fact that the current detection hangs suggests that the scenario is
> possible to detect.
> 

Hm, OK.  I'll go back and look at i8042_flush() to see if I can detect this
erroneous situation automatically and fail the i8042_controller_init() if I see it.

Chris Lalancette
