From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: EKR: ensure devres groups at higher indexes
 are released
Date: Tue, 23 Jan 2018 15:30:39 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231530250.11852@cbobk.fhfr.pm>
References: <1512678716-31779-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1512678716-31779-1-git-send-email-skomra@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, benjamin.tissoires@redhat.com, "stable #4 . 9" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

On Thu, 7 Dec 2017, Aaron Armstrong Skomra wrote:

> Background: ExpressKey Remotes communicate their events via usb dongle.
> Each dongle can hold up to 5 pairings at one time and one EKR (identified
> by its serial number) can unfortunately be paired with its dongle
> more than once. The pairing takes place in a round-robin fashion.
> 
> Input devices are only created once per EKR, when a new serial number
> is seen in the list of pairings. However, if a device is created for
> a "higher" paring index and subsequently a second pairing occurs at a
> lower pairing index, unpairing the remote with that serial number from
> any pairing index will currently cause a driver crash. This occurs
> infrequently, as two remotes are necessary to trigger this bug and most
> users have only one remote.
> 
> As an illustration, to trigger the bug you need to have two remotes,
> and pair them in this order:
> 
> 1. slot 0 -> remote 1 (input device created for remote 1)
> 2. slot 1 -> remote 1 (duplicate pairing - no device created)
> 3. slot 2 -> remote 1 (duplicate pairing - no device created)
> 4. slot 3 -> remote 1 (duplicate pairing - no device created)
> 5. slot 4 -> remote 2 (input device created for remote 2)
> 
> 6. slot 0 -> remote 2 (1 destroyed and recreated at slot 1)
> 7. slot 1 -> remote 2 (1 destroyed and recreated at slot 2)
> 8. slot 2 -> remote 2 (1 destroyed and recreated at slot 3)
> 9. slot 3 -> remote 2 (1 destroyed and not recreated)
> 10. slot 4 -> remote 2 (2 was already in this slot so no changes)
> 
> 11. slot 0 -> remote 1 (The current code sees remote 2 was paired over in
>                         one of the dongle slots it occupied and attempts
>                         to remove all information about remote 2 [1]. It
>                         calls wacom_remote_destroy_one for remote 2, but
>                         the destroy function assumes the lowest index is
>                         where the remote's input device was created. The
>                         code "cleans up" the other remote 2 pairings
>                         including the one which the input device was based
>                         on, assuming they were were just duplicate
>                         pairings. However, the cleanup doesn't call the
>                         devres release function for the input device that
>                         was created in slot 4).
> 
> This issue is fixed by this commit.
> 
> [1] Remote 2 should subsequently be re-created on the next packet from the
> EKR at the lowest numbered slot that it occupies (here slot 1).
> 
> Fixes: f9036bd43602 ("HID: wacom: EKR: use devres groups to manage resources")
> Cc: stable <stable@vger.kernel.org> #4.9
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
