From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Tue, 21 Aug 2007 13:02:33 -0700
Message-ID: <20070821130233.58faaa8a.akpm@linux-foundation.org>
References: <20070821005718.GD3658@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070821005718.GD3658@interface.famille.thibault.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, dtor@mail.ru, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Aug 2007 02:57:18 +0200
Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Some external modules like Speakup need to use the PC keyboard to control
> them and also need to get keyboard feedback (caps lock status, etc.)
> 
> This adds a keyboard notifier that such modules can use to get the keyboard
> events and possibly eat them, at several stages:

Adding hooks for non-merged modules is considered sinful.  Making these new
exports EXPORT_SYMBOL_GPL might ease the pain.

Is there any prospect of getting at least one of these "external modules
like Speakup" merged into mainline?
